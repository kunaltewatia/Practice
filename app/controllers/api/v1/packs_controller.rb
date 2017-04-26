module Api
  module V1
    # PackController
    class PacksController < ApiController
      def index
        packs = Pack.where(service_id: params[:service_id], is_active: true, is_visible: true)
        render json: packs, each_serializer: PackIndexSerializer
      end
    end
  end
end
