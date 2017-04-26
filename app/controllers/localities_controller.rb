# Locality Controller
class LocalitiesController < ApplicationController
  before_action :set_locality, only: [:show, :edit, :update, :destroy]
  before_action :set_areas, except: [:index, :destroy]
  before_action :pagination_params, only: [:index]
  # GET /localities
  # GET /localities.json
  def index
    @localities = Locality.paginate(page: @page, per_page: @per_page)
  end

  # GET /localities/1
  # GET /localities/1.json
  def show
  end

  # GET /localities/new
  def new
    @locality = Locality.new
    @service_ids = @locality.services.pluck(:service_id)
  end

  # POST /localities
  # POST /localities.json
  def create
    @locality = Locality.new(locality_params)
    respond_to do |format|
      if @locality.save
        format.html do
          redirect_to localities_url, notice: 'Locality successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /localities/1
  # PATCH/PUT /localities/1.json
  def update
    respond_to do |format|
      if @locality.update(locality_params)
        format.html do
          redirect_to localities_url, notice: 'Locality successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /localities/1
  # DELETE /localities/1.json
  def destroy
    @locality.destroy
    respond_to do |format|
      format.html do
        redirect_to localities_url,
                    notice: 'Locality was successfully destroyed.'
      end
    end
  end

  def list
    area = Area.find(params[:area_id])
    localities = area.localities.active
    render json: localities
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_locality
    @locality = Locality.find(params[:id])
    @service_ids = @locality.services.pluck(:service_id)
  end

  def set_areas
    @areas = Area.select('id', 'name')
    @services = Service.select('id', 'name')
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def locality_params
    params.require(:locality)
      .permit(:name, :area_id, :is_active,
              locality_services_attributes: [:id, :service_id, :_destroy])
  end
end
