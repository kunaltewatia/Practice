# Controller delivery
class DeliveriesController < ApplicationController
  include DeliveryModule

  before_action :set_search, only: [:index]
  before_action :set_delivery, only: [:show, :edit, :update, :destroy]
  before_action :pagination_params, only: [:index]
  before_action :load_prerequisites1, only: [:new, :edit]
  before_action :load_prerequisites2, only: [:new, :edit]
  before_action :load_deliveries, only: [:excel]

  def index
    @deliveries = @search.result.includes(
      :mobile_user, :pack, :plan, :country, :state, :city, :area, :locality,
      :society, :wing, :complaint
    ).paginate(page: @page, per_page: @per_page)
  end

  def excel
    societies = find_distinct_society
    p = Axlsx::Package.new
    p = create_excel_data(p, societies)
    date = down_date
    file_name = "/tmp/Delivery-#{date}.xlsx"
    p.serialize(file_name)
    send_file file_name
  end

  def new
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new(permitted_params)
    respond_to do |format|
      if @delivery.save
        format.html do
          redirect_to @delivery, notice: 'Delivery was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @delivery.update(permitted_params)
        format.html do
          redirect_to @delivery, notice: 'Delivery was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @delivery.destroy
    redirect_to deliveries_url, notice: 'Delivery was successfully destroyed.'
  end

  private

  def set_search
    if params[:q] && params[:q][:date_date_equals]
      @search = Delivery.ransack(params[:q])
    else
      @search = Delivery.ransack(date_date_equals: Date.current)
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_delivery
    @delivery = Delivery.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the
  # white list through.
  def permitted_params
    params.require(:delivery)
      .permit(
        :mobile_user_id, :pack_id, :plan_id, :country_id, :state_id,
        :city_id, :area_id, :locality_id, :society_id, :wing_id, :complaint_id,
        :flat_no
      )
  end

  def load_prerequisites1
    @mobile_users = Customer.verified
    @packs = Pack.active
    @plans = Plan.active
    @countries = Country.active
    @states = State.active
  end

  def load_prerequisites2
    @cities = City.active
    @areas = Area.active
    @localities = Locality.active
    @societies = Society.active
    @wings = Wing.active
    @complaints = Complaint.active
  end

  def load_deliveries
    if params[:q] && params[:q][:date_date_equals]
      @search = Delivery.ransack(params[:q])
    else
      @search = Delivery.ransack(date_date_equals: Date.current)
    end
    @deliveries = @search.result.includes(
      :mobile_user, :pack, :plan, :country, :state, :city, :area, :locality,
      :society, :wing, :complaint, :subscription
    )
  end

  def find_distinct_society
    @deliveries.select(:society_id).distinct.pluck(:society_id)
  end
end
