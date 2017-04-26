module Api
  module V2
    # This fetches all collection record
    class ListsController < ApiController
      def categories
        result = {}
        result[:complaint_categories] = ComplaintCategory.select('id, name')
                                        .active.as_json.collect do |i|
                                          i.merge(type: 'C')
                                        end

        result[:feedback_categories] = FeedbackCategory.select('id, name')
                                       .active.as_json.collect do |i|
                                         i.merge(type: 'F')
                                       end
        render json: result
      end

      def countries
        country_list = Country.order(:name).all
        render json: country_list, root: :countries,
               each_serializer: ListCountrySerializer
      end

      def states
        state_list = State.order(:name).where(country_id: params[:country_id])
        render json: state_list, root: :states,
               each_serializer: ListStateSerializer
      end

      def cities
        city_list = City.order(:name).where(state_id: params[:state_id])
        render json: city_list, root: :cities,
               each_serializer: ListCitySerializer
      end

      def areas
        area_list = Area.order(:name).where(city_id: params[:city_id])
        render json: area_list, root: :areas,
               each_serializer: ListAreaSerializer
      end

      def localities
        locality_list = Locality.order(:name).where(area_id: params[:area_id])
        render json: locality_list, root: :localities,
               each_serializer: ListLocalitySerializer
      end

      def societies
        society_list = Society.order(:name)
                       .where(locality_id: params[:locality_id])
        render json: society_list, root: :societies,
               each_serializer: ListSocietySerializer
      end

      def wings
        wing_list = Wing.order(:name).where(society_id: params[:society_id])
        render json: wing_list, root: :wings,
               each_serializer: ListWingSerializer
      end

      def group_areas
        area_list = Area.order(:name)
                    .includes(localities: [societies: [:wings]])
                    .where(city_id: params[:city_id])
        render json: area_list, root: :areas,
               each_serializer: GroupAreaSerializer
      end
    end
  end
end
