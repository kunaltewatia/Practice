# Plan controller
class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :set_product, except: [:index, :destroy]
  before_action :pagination_params, only: [:index]
  before_action :set_city, only: [:show, :edit, :update, :destroy, :index, :new]

  def index
    @plans = Plan.active.paginate(page: @page, per_page: @per_page)
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        format.html do
          redirect_to plans_url, notice: 'Plan was successfully created.'
        end

      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html do
          redirect_to plans_url, notice: 'Plan was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @plan.destroy
    respond_to do |format|
      format.html do
        redirect_to plans_url, notice: 'Plan was successfully destroyed.'
      end
    end
  end

  def list
    pack = Pack.find(params[:pack_id])
    plans = pack.plans.active
    render json: plans
  end

  def delete
    plan = Plan.find(params[:id])
    plan.is_active = false
    plan.save
    respond_to do |format|
      format.html do
        redirect_to plans_url, notice: 'Plan was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_plan
    @plan = Plan.find(params[:id])
  end

  def set_city
    @cities = City.active.select('id', 'name')
  end

  def set_product
    @products = Product.active.select('id', 'name')
  end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def plan_params
    params.require(:plan).permit(:pack_id, :name, :description, :old_price,
                                 :decimal, :price, :days, :is_active,
                                 :is_visible, :product_id, :city_id, :city_name)
  end
end
