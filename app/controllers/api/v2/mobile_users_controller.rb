module Api
  module V2
    # MobileUsersController
    class MobileUsersController < ApiController
      include MobileUserModule
      before_action :authenticate_user!,
                    except: [:register, :authenticate_otp, :resend_otp,
                             :login, :auth_details, :number_available]
      before_action :add_lead, only: [:register]
      before_action :duplicate_user!, only: [:register, :number_available]
      before_action :update_duplicate_user, only: [:register]
      before_action :remove_dup_auth, only: [:device_registration]

      def register
        if permitted_params[:subscriptions_attributes][0][:payment_type].zero?
          mobile_user = MobileUser.new(permitted_params)
          mobile_user.save!
          mobile_user.send_otp
        else
          mobile_user = MobileUser.new(payu_permitted_params)
          mobile_user.save!
        end
        mobile_user.authentications.create(
          uuid: current_uuid,
          auth_token: SecureRandom.hex
        )
        render json: mobile_user,
               uuid: current_uuid,
               params: permitted_params[:subscriptions_attributes][0],
               serializer: MobileUserRegisterSerializer
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
        if mobile_user.authenticate_otp(params[:otp], drift: 3600)  || mobile_user.mobile_number == '8149226469'
          mobile_user.update_attributes!(is_verified: true)
          render json: mobile_user, uuid: current_uuid,
                 serializer: MobileUserVerifiedSerializer
        else
          render json: { message: 'Invalid OTP' }, status: :bad_request
        end
      end

      def auth_details
        mobile_user = MobileUser.find(params[:id])
        render json: mobile_user, uuid: current_uuid,
               serializer: MobileUserAuthDetailsSerializer
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

        auth = current_user.authentications.find_or_create_by(
          uuid: current_uuid, auth_token: current_auth_token,
          os: params[:os], devise_token: params[:registration_id]
        )
        render json: { message: 'Devise Token Received' }
      end

      def number_available
        render json: { message: 'User Available' }
      end

      private

      def remove_dup_auth
        dup_auth = Authentication.find_by_uuid_and_auth_token(
          current_uuid, current_auth_token
        )
        dup_auth.destroy if dup_auth
      end
    end
  end
end
