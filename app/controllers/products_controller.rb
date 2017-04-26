# Product Controller
class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_services, except: [:index, :destroy]
  before_action :pagination_params, only: [:index]

  def index
    @products = Product.active.includes(:service).search(params[:search]).paginate(page: @page,
                                                         per_page: @per_page)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html do
          redirect_to products_url, notice: 'Product was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html do
          redirect_to products_url, notice: 'Product was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html do
        redirect_to products_url, notice: 'Product was successfully destroyed.'
      end
    end
  end

  def delete
    product = Product.find(params[:id])
    product.is_active = false
    product.plans.update_all(is_active: false)
    product.save
    respond_to do |format|
      format.html do
        redirect_to products_url, notice: 'Product was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  def set_services
    @services = Service.select('id', 'name')
  end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def product_params
    params.require(:product).permit(:service_id, :name,
                                    :origin, :description, :is_active, :banner,
                                    :listing, :side, :is_discounted)
  end
end
