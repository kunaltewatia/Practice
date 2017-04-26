class OrdersController < ApplicationController
  include OrderDeliveryModule
  before_action :set_search, only: [:index]
  before_action :load_order, only: [:excel]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_services, except: [:index, :destroy]
  before_action :pagination_params, only: [:index]
  before_filter :authenticate_user!, except: [:create, :update, :index]

  def index
    @orders = @search.result.where(status: ['Completed', 'Pending']).paginate(page: @page,
                                                      per_page: @per_page)
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html do
          redirect_to orders_url, notice: 'Order was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html do
          redirect_to orders_url, notice: 'Order was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html do
        redirect_to orders_url, notice: 'Order was successfully destroyed.'
      end
    end
  end

  def excel
    areas = find_distinct_area
    p = Axlsx::Package.new
    p = create_excel_data(p, areas)
    date = down_date
    file_name = "/tmp/Delivery-#{date}.xlsx"
    p.serialize(file_name)
    send_file file_name
  end

  def paid
    order = Order.find(params[:id])
    order.send_notification_cod_paid
    order.is_paid = true
    order.status = 'Completed'
    order.save
    redirect_to orders_url, notice: 'Order payment status was successfully updated.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  def set_services
    @seasonal_domains = SeasonalDomain.select('id', 'name')
    @products = Product.select('id', 'name')
    @plans = Plan.select('id', 'name')
    @areas = Area.select('id', 'name')
  end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def order_params
    params.require(:order).permit(:product_id, :plan_id, :area_id,
                                  :user_name, :address, :mobile_number)
  end

  def set_search
    if params[:q] && params[:q][:delivery_date_date_equals]
      @search = Order.ransack(params[:q])
    else
      @search = Order.ransack(delivery_date_date_equals: Date.current.next)
    end
  end

  def load_order
    if params[:q] && params[:q][:delivery_date_date_equals]
      @search = Order.ransack(params[:q])
    else
      @search = Order.ransack(delivery_date_date_equals: Date.current.next)
    end
    @orders = @search.result.where(status: ['Completed', 'Pending'])
  end

  def find_distinct_area
    @orders.select(:area_id).distinct.pluck(:area_id)
  end
end
