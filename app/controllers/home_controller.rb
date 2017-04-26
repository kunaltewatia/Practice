class HomeController < ApplicationController
  include OrderModule

  before_filter :set_cache_headers
  before_filter :authenticate_user!, except: [:index, :create_order,
    :complaint, :register_complaint, :cart, :review, :calc_price, :contact,
    :terms, :complaint_submitted, :selected_areas, :policies]
    before_filter :create_order_object, only: [:create_order]
  before_filter :load_data, only: [:create_order, :cart]
  skip_before_filter :verify_authenticity_token, :only => [:calc_price]
  before_filter :selected_areas, only: [:cart, :index]

  def index
    @plans = Plan.active.includes(:product).all.where(city_id: params[:city_id])
    #@areas = Area.active.order(:name)
    # html for down site
    # render :down
  end

  def cart
    if params[:plan_id]
      @order = Order.new(plan_id: @plan.id, product_id: @plan.product.id,
        unit: '1', payment_type: '2', status: 'Started')
      @plan = @order.plan
    else
      @order = Order.find(params[:id])
    end
    unit = @order.unit.to_i
    unit = unit
    nprice, ndiscount, ntext = calc_discount(@plan, unit + 1, false)
    #@text = "Buy #{unit + 1} dozens to avail discount worth Rs #{ndiscount.to_i}/-"
    @text = "Buy #{unit + 1} dozen and Save Rs #{ndiscount.to_i}/-"
    redirect_to '/' if @order.status != 'Started'
  end

  def create_order
    respond_to do |format|
      if @order.save
        format.html do
          redirect_to "/review/#{@order.id}?city_id=#{params[:order][:city_id]}"
        end
      else
        unit = @order.unit.to_i
        nprice, ndiscount, ntext = calc_discount(@plan, unit, false)
        @text = "Buy #{unit + 1} dozen and Save Rs #{ndiscount.to_i}/-"
        format.html { render :cart }
      end
    end
  end

  def complaint
    @complaint = Complaint.new
  end

  def register_complaint
    update_complaint_params
    @complaint = Complaint.new(complaint_params)
    if @complaint.save
      redirect_to "/complaint_submitted"
    else
      render :complaint
    end
  end

  def review
    @order = Order.find(params[:id])
    redirect_to '/' if @order.status != 'Started'
  end

  def calc_price
    plan = Plan.find(params[:plan_id])
    unit = params[:unit].to_i
    if plan.product.is_discounted
      price, discount, text = calc_unit(plan, unit)
      render json: { price: price, discount: discount, text: text }
    else
      price = plan.price.to_i * unit
      render json: { price: price, discount: 0, text: text }
    end
  end

  def contact
  end

  def terms
  end

  def policies
  end

  def complaint_submitted
  end

  def selected_areas
    if params[:city_id].present?
      @city = City.find(params[:city_id])
      @areas = @city.areas.order(:name)
    else
      @areas = Area.active.order(:name)
    end
  end

  private

  def load_data
    @products = Product.active
    if params[:plan_id] || params[:order]
      plan_id = params[:plan_id] || params[:order][:plan_id]
      @plan  = Plan.find(plan_id)
    else
      @order = Order.find(params[:id])
      @plan = @order.plan
    end
    @plans = @plan.product.plans
    @areas = Area.active.order(:name)
  end

  def order_params
    params.require(:order).permit(:product_id, :plan_id, :area_id, :user_name,
                                  :address, :mobile_number, :unit,
                                  :payment_type)
  end

  def complaint_params
    params.require(:complaint)
      .permit(:mobile_user_id, :user_id, :complaint_category_id,
              :text, :admin_comment, :status, :is_extra_fruit, :is_resolved,
              :date, :fruit_name, :image, :order_id, :txt_id)
  end

  def update_complaint_params
    order = Order.find_by_txt_id(params[:complaint][:txt_id])
    params[:complaint][:order_id] = order.id if order
  end

  def create_order_object
    if params[:order] && params[:order][:id].present?
      @order = Order.find(params[:order][:id])
      @order.update_attributes(order_params)
    else
      @order = Order.new(order_params)
    end
  end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
