module Api
  module V1
    # Generic API stuff here in this class
    # TODO : Need to have a basic authentication to verify that
    # request cming from our app
    class ApiController < ApplicationController
      protect_from_forgery with: :null_session
      skip_before_filter :authenticate_user!

      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_response
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

      attr_reader :current_user

      def default_serializer_options
        { root: false }
      end

      def authenticate_user!
        @current_user = MobileUser.find_by_mobile_number!(current_mobile_number)
        auth = @current_user.authentications.find_by_uuid_and_auth_token(
          current_uuid, current_auth_token
        )

        return unauthorized_user if @current_user.nil? && auth.nil?

        render json: { message: 'User Not Verified' },
               status: :precondition_failed unless @current_user.is_verified
      end

      protected

      def record_invalid_response(exception)
        message = ''
        exception.record.errors.each do |key, error|
          keyname = key.to_s.sub('.', ':').humanize
          message << keyname << ' ' << error.to_s << '. '
        end
        render json: { message: message },
               status: :unprocessable_entity
      end

      def record_not_found_response(_exception)
        render json: { message: 'Record Not Found' }, status: :not_found
      end

      private

      def current_uuid
        request.headers[:uuid]
      end

      def current_auth_token
        request.headers[:HTTP_AUTH] || request.headers[:auth]
      end

      def current_mobile_number
        request.headers[:HTTP_NUMBER] || request.headers[:number]
      end

      def unauthorized_user
        render json: { message: 'User Not registered' }, status: :unauthorized
      end

      def unsubscribed_user
        msg = "Sorry, this number is not registered in our database. Please \
        create a new Subscription to register yourself."
        render json: { message: msg }, status: :unauthorized
      end
    end
  end
end
