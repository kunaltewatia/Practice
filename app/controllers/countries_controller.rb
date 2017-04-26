# Country Controller
class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]
  before_action :pagination_params, only: [:index]

  def index
    @countries = Country.active.paginate(page: @page, per_page: @per_page)
  end

  def new
    @country = Country.new(is_active: true)
  end

  def create
    @country = Country.new(country_params)

    respond_to do |format|
      if @country.save
        format.html do
          redirect_to countries_url, notice: 'Country was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html do
          redirect_to countries_url, notice: 'Country was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @country.destroy
    respond_to do |format|
      format.html do
        redirect_to countries_url, notice: 'Country was successfully destroyed.'
      end
    end
  end

  def delete
    country = Country.find(params[:id])
    country.is_active = false
    country.save
    respond_to do |format|
      format.html do
        redirect_to countries_url, notice: 'Country was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_country
    @country = Country.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list .
  def country_params
    params.require(:country).permit(:sortname, :name)
  end
end
