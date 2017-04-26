# CustomersController
class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_filter :set_country_pack, except: [:index]
  before_action :pagination_params, only: [:index, :show]
  def index
    # @customers = Customer.includes(address: [:area, :locality, :society, :wing],
    #   subscriptions: [plan: :pack]).order(id: :desc).search(params).paginate(
    #     page: @page, per_page: @per_page)
    # city = City.first
    # @areas = city.areas.active
  end

  def new
    @customer = Customer.new
    @customer.build_address
  end

  def create
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        format.html do
          redirect_to customers_url, notice: 'Customer successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_url, notice: 'Customer was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_url, notice: 'Customer was successfully destroyed.'
  end

  def show
    @subscriptions = @customer.subscriptions.includes(plan: [:pack])
                     .order(created_at: :desc).paginate(page: @page,
                                                        per_page: @per_page)
  end

  def set_customer
    @customer = Customer.includes(:address, subscriptions: [plan: :pack])
                .find(params[:id])
  end

  def set_country_pack
    @countries = Country.select('id', 'name').active
    @packs = Pack.select('id', 'name').active
  end

  def search
    if params[:name].blank?
      @customers = Customer.pluck(:first_name, :last_name, :id)
    else
      name = params[:name]
      @customers = Customer.where("first_name LIKE ? OR last_name LIKE ? OR \
        mobile_number LIKE ?", "%#{name}%", "%#{name}%", "%#{name}%")
                   .select(:first_name, :last_name, :mobile_number, :id)
    end
    render json: @customers
  end

  private

  def customer_params
    params.require(:customer)
      .permit(:id, :first_name, :last_name, :mobile_number, :type,
              :is_verified, :exceptions, :notes,
              address_attributes: [:id, :flat_no, :mobile_user_id,
                                   :country_id, :state_id, :city_id,
                                   :area_id, :locality_id,
                                   :society_id, :wing_id])
  end
end
