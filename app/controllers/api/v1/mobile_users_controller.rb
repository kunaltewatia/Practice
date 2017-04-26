module Api
  module V1
    # MobileUsersController
    class MobileUsersController < ApiController
      include MobileUserModule
      before_action :authenticate_user!,
                    except: [:register, :authenticate_otp, :resend_otp, :login]
      before_action :add_lead, only: [:register]
      before_action :duplicate_user!, only: [:register]
      before_action :duplicate_referral!, only: [:referral]

      def register
        mobile_user = MobileUser.new(permitted_params)
        mobile_user.save!
        mobile_user.send_otp
        mobile_user.authentications.create(uuid: current_uuid,
                                           auth_token: SecureRandom.hex)
        update_referral_info(mobile_user)
        render json: mobile_user, uuid: current_uuid,
               serializer: MobileUserVerifiedSerializer
      end

      def update_referral_info(mobile_user)
        ref = Referral.find_by_contact(permitted_params[:mobile_number])
        ref.update(is_converted: true, referred_id: mobile_user.id) if
        ref.present?
      end

      def referral
        referral = Referral.new(permitted_referral_params)
        referral.save!
        # render json: referral, serializer: ReferralSerializer
        render json: { message: 'Referred Successfully.' }
      end

      def login
        mobile_user = MobileUser.find_by(
          mobile_number: permitted_params[:mobile_number]
        )
        return unsubscribed_user if mobile_user.nil?
        auth = create_authentication(mobile_user)
        return unauthorized_user if mobile_user.nil? && auth
        mobile_user.save!
        mobile_user.send_otp
        render json: { message: 'OTP sent', mobile_user_id: mobile_user.id }
      end

      def update
        mobile_user = MobileUser.find(params[:id])
        mobile_user.update_attributes!(permitted_params)
        render json: mobile_user
      end

      def authenticate_otp
        mobile_user = MobileUser.find(params[:id])
        if mobile_user.authenticate_otp(params[:otp], drift: 3600)
          mobile_user.update_attributes!(is_verified: true)
          render json: mobile_user, uuid: current_uuid,
                 serializer: MobileUserVerifiedSerializer
        else
          render json: { message: 'Invalid OTP' }, status: :bad_request
        end
      end

      def resend_otp
        mobile_user = MobileUser.find_by!(mobile_number: params[:mobile_number])
        mobile_user.is_verified = false
        mobile_user.save!
        mobile_user.send_otp
        render json: { message: 'OTP sent' }
      end

      def customer_details
        mobile_user = MobileUser.find_by_mobile_number!(current_mobile_number)
        render json: mobile_user, serializer: CustomerDetailSerializer
      end

      def device_registration
        current_user = MobileUser.find_by_mobile_number!(current_mobile_number)
        auth = current_user.authentications.find_by_uuid_and_auth_token!(
          current_uuid, current_auth_token
        )
        auth.update_attributes(devise_token: params[:registration_id])
        render json: { message: 'Devise Token Received' }
      end
    end
  end
end
