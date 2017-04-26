# LocalityServicesController
class LocalityServicesController < ApplicationController
  before_action :locality_service, only: [:show, :edit, :update, :destroy]
  before_action :set_localities, except: [:index, :destroy]
  before_action :set_services, except: [:index, :destroy]
  def index
    @locality_services = LocalityService.paginate(page: params[:page])
  end

  def new
    @locality_service = LocalityService.new
  end

  def create
    @locality_service = LocalityService.new(locality_service_params)

    respond_to do |format|
      if @locality_service.save
        format.html do
          redirect_to @locality_service, notice: 'Successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @locality_service.update(locality_service_params)
        format.html do
          redirect_to @locality_service, notice: 'Successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @locality_service.destroy
    respond_to do |format|
      format.html do
        redirect_to locality_services_url, notice: 'Service Available Area
        successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def locality_service
    @locality_service = LocalityService.find(params[:id])
  end

  def set_services
    @services = Service.select('id', 'name')
  end

  def set_localities
    @localities = Locality.select('id', 'name')
  end

  def locality_service_params
    params.require(:locality_service).permit(:service_id, :locality_id,
                                             :is_active)
  end
end
