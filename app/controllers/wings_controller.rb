# Wing Controller
class WingsController < ApplicationController
  before_action :set_wing, only: [:show, :edit, :update, :destroy]
  before_action :set_societies, except: [:index, :destroy]

  def index
    @wings = Wing.paginate(page: params[:page])
  end

  def new
    @wing = Wing.new
  end

  def create
    @wing = Wing.new(wing_params)

    respond_to do |format|
      if @wing.save
        format.html do
          redirect_to @wing, notice: 'Wing was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @wing.update(wing_params)
        format.html do
          redirect_to @wing, notice: 'Wing was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @wing.destroy
    respond_to do |format|
      format.html do
        redirect_to wings_url, notice: 'Wing was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def list
    society = Society.find(params[:society_id])
    wings = society.wings
    render json: wings
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_wing
    @wing = Wing.find(params[:id])
  end

  def set_societies
    @societies = Society.select('id', 'name')
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def wing_params
    params.require(:wing).permit(:name, :society_id, :is_active)
  end
end
