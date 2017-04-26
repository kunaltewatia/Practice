# Measurement controller
class MeasurementsController < ApplicationController
  before_action :set_measurement, only: [:show, :edit, :update, :destroy]

  def index
    @measurements = Measurement.all
  end

  def new
    @measurement = Measurement.new
  end

  def create
    @measurement = Measurement.new(measurement_params)
    respond_to do |format|
      if @measurement.save
        format.html do
          redirect_to @measurement, notice: 'Measurement successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @measurement.update(measurement_params)
        format.html do
          redirect_to @measurement, notice: 'Measurement successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @measurement.destroy
    respond_to do |format|
      format.html do
        redirect_to measurements_url,
                    notice: 'Measurement was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_measurement
    @measurement = Measurement.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def measurement_params
    params.require(:measurement).permit(:name, :unit)
  end
end
