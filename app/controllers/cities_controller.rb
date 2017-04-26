# City Controller
class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]
  before_action :set_states, except: [:index, :destroy]
  before_action :pagination_params, only: [:index]

  def index
    @cities = City.paginate(page: @page, per_page: @per_page)
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html do
          redirect_to cities_url, notice: 'City was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html do
          redirect_to cities_url, notice: 'City was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @city.destroy
    respond_to do |format|
      format.html do
        redirect_to cities_url, notice: 'City was successfully destroyed.'
      end
    end
  end

  def list
    state = State.find(params[:state_id])
    cities = state.cities.active
    render json: cities
  end

  def delete
    city = City.find(params[:id])
    city.is_active = false
    city.save
    respond_to do |format|
      format.html do
        redirect_to cities_url, notice: 'City was successfully destroyed.'
      end
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_city
    @city = City.find(params[:id])
  end

  def set_states
    @states = State.select('id', 'name')
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def city_params
    params.require(:city).permit(:name, :state_id)
  end
end
