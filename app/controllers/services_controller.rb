# Service Controller
class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :parent_services, except: [:destory, :index]
  before_action :pagination_params, only: [:index]

  def index
    @services = Service.paginate(page: @page, per_page: @per_page)
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    respond_to do |format|
      if @service.save
        format.html do
          redirect_to services_url, notice: 'Service was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html do
          redirect_to services_url, notice: 'Service was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @service.destroy
    respond_to do |format|
      format.html do
        redirect_to services_url, notice: 'Service was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find(params[:id])
  end

  def parent_services
    @services = Service.select('id', 'name')
  end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def service_params
    params.require(:service).permit(:name, :description, :parent_id, :is_active)
  end
end
