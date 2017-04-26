# State Controller
class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]
  before_action :set_countries, except: [:index, :destroy]
  before_action :pagination_params, only: [:index]

  def index
    @states = State.active.paginate(page: @page, per_page: @per_page)
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(state_params)

    respond_to do |format|
      if @state.save
        format.html do
          redirect_to states_url, notice: 'State was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @state.update(state_params)
        format.html do
          redirect_to states_url, notice: 'State was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @state.destroy
    respond_to do |format|
      format.html do
        redirect_to states_url, notice: 'State was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def list
    country = Country.find(params[:country_id])
    states = country.states.active
    render json: states
  end

  def delete
    state = State.find(params[:id])
    state.is_active = false
    state.save
    respond_to do |format|
      format.html do
        redirect_to states_url, notice: 'State was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_state
    @state = State.find(params[:id])
  end

  def set_countries
    @countries = Country.select('id', 'name')
  end

  # Never trust parameters from the scary internet, only allow the white list .
  def state_params
    params.require(:state).permit(:name, :country_id)
  end
end
