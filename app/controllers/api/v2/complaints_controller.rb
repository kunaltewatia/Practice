module Api
  module V2
    # ComplaintsController
    class ComplaintsController < ApiController
      before_action :authenticate_user!, except: [:register]

      def register
        complaint = Complaint.new(complaint_params)
        complaint.save!
        render json: { message: 'Complaint registered Successfully.' }
      end

      def index
        mobile_user = MobileUser.find_by_mobile_number!(current_mobile_number)
        render json: { feedback_complaints: mobile_user.received_complaints }
      end

      private

      def complaint_params
        params.permit(:mobile_user_id, :complaint_category_id, :text, :image,
                      :date, :fruit_name)
      end
    end
  end
end
