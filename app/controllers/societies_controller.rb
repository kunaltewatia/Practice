# Society Controller
class SocietiesController < ApplicationController
  before_action :set_society, only: [:show, :edit, :update, :destroy]
  before_action :set_city_areas, except: [:index, :destroy]
  before_action :pagination_params, only: [:index]

  def index
    @societies = Society.includes(:wings).paginate(page: @page,
                                                   per_page: @per_page)
  end

  def new
    @society = Society.new
    select_model(params[:target])
    respond_to do |format|
      format.js { render :new }
      format.html
    end
  end

  def create
    @society = Society.new(society_params)
    respond_to do |format|
      if @society.save
        format.html do
          redirect_to societies_url, notice: 'Society was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @areas = Area.where(city_id: City.first.id).active
    @localities = Locality.where(area_id: @society.locality.area.id).active
  end

  def update
    respond_to do |format|
      if @society.update(society_params)
        format.html do
          redirect_to societies_url, notice: 'Society was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @society.destroy
    respond_to do |format|
      format.html do
        redirect_to societies_url, notice: 'Society was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def list
    locality = Locality.find(params[:locality_id])
    societies = locality.societies.active
    render json: societies
  end

  def create_locality
    @target = Locality.new(locality_params)
    respond_to do |format|
      @target.save
      @localities = Locality.where(area_id: locality_params[:area_id]).active
      format.js { render :create_locality }
    end
  end

  def create_area
    @target = Area.new(area_params)
    @areas = Area.where(city_id: area_params[:city_id])

    respond_to do |format|
      @target.save
      format.js { render :create_area }
    end
  end

  private

  def set_society
    @society = Society.find(params[:id])
  end

  def set_city_areas
    @city = City.active.first
    @areas = @city.areas.active
    @localities = []
  end

  def select_model(target)
    case target
    when 'Area'
      @target = Area.new
    when 'Locality'
      @target = Locality.new
    end
  end

  def area_params
    params.require(:area).permit(:name, :city_id, :is_active)
  end

  def locality_params
    params.require(:locality).permit(:name, :area_id, :is_active)
  end

  def society_params
    params.require(:society)
      .permit(:name, :locality_id, :latitude, :longlatitude, :is_active,
              wings_attributes: [:id, :name, :society_id, :_destroy])
  end
end
