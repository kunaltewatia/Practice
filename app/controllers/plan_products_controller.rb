# plan_product controller for daily packages
class PlanProductsController < ApplicationController
  before_action :set_plan_product, only: [:show, :edit, :update, :destroy]

  def index
    @plan_products = PlanProduct.paginate(page: params[:page])
  end

  def new
    @plan_product = PlanProduct.new
  end

  def create
    @plan_product = PlanProduct.new(plan_product_params)
    respond_to do |format|
      if @plan_product.save
        format.html do
          redirect_to @plan_product, notice: 'Planed Product successfully.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @plan_product.update(plan_product_params)
        format.html do
          redirect_to @plan_product,
                      notice: 'Plan product was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @plan_product.destroy
    respond_to do |format|
      format.html do
        redirect_to plan_products_url,
                    notice: 'Plan product was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_plan_product
    @plan_product = PlanProduct.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def plan_product_params
    params.require(:plan_product)
      .permit(:product_id, :package_id, :measurement_id, :date, :quantity)
  end
end
