# Area Controller
class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  before_action :set_cities, except: [:index, :destroy]
  before_action :pagination_params, only: [:index]

  def index
    @areas = Area.active.paginate(page: @page, per_page: @per_page)
  end

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(area_params)
    respond_to do |format|
      if @area.save
        format.html do
          redirect_to areas_url, notice: 'Area was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @area.update(area_params)
        format.html do
          redirect_to areas_url, notice: 'Area was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @area.destroy
    respond_to do |format|
      format.html do
        redirect_to areas_url, notice: 'Area was successfully destroyed.'
      end
    end
  end

  def list
    city = City.find(params[:city_id])
    areas = city.areas.active
    render json: areas
  end

  def delete
    area = Area.find(params[:id])
    area.is_active = false
    area.save
    respond_to do |format|
      format.html do
        redirect_to areas_url, notice: 'Area was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_area
    @area = Area.find(params[:id])
  end

  def set_cities
    @cities = City.select('id', 'name')
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def area_params
    params.require(:area).permit(:name, :city_id)
  end
end
