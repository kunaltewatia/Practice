# Controller package
class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]
  before_action :set_plans, expect: [:index, :destroy]

  def index
    @packages = Package.paginate(page: params[:page])
  end

  def new
    @package = Package.new
  end

  def create
    @package = Package.new(package_params)

    respond_to do |format|
      if @package.save
        format.html do
          redirect_to @package, notice: 'Package was successfully created.'
        end

      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @package.update(package_params)
        format.html do
          redirect_to @package, notice: 'Package was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @package.destroy
    respond_to do |format|
      format.html do
        redirect_to packages_url, notice: 'Package was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_package
    @package = Package.find(params[:id])
  end

  def set_plans
    @plans = Plan.select('id', 'name')
  end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def package_params
    params.require(:package).permit(:name, :plan_id, :date,
                                    plan_products_attributes: [:id,
                                                               :product_id,
                                                               :quantity,
                                                               :measurement_id])
  end
end
