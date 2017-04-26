# Domain controller
class SeasonalDomainsController < ApplicationController
  before_action :pagination_params, only: [:index]
  before_action :find_seasonaldomain, only: [:show, :update, :destroy, :edit]

  def index
    @seasonal_domains = SeasonalDomain.paginate(page: @page, per_page: @per_page)
  end

  def show
    @seasonal_domain = SeasonalDomain.find_by(id: params[:id])
  end  

  def new
    @seasonal_domain = SeasonalDomain.new
  end

  def edit
  end
  
  def create
    @seasonal_domain = SeasonalDomain.new(seasonal_domain_params)

    respond_to  do |format|
      if @seasonal_domain.save
        format.html do
          redirect_to seasonal_domains_url, notice: 'Seasonal Domain was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @seasonal_domain.update(seasonal_domain_params)
        format.html do
          redirect_to seasonal_domains_url, notice: 'Seasonal Domain was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end
  
  def destroy
    @seasonal_domain.destroy
    respond_to do |format|
      format.html do
        redirect_to seasonal_domains_url, notice: 'Seasonal Domain was successfully destroyed.'
      end
    end
  end

  private

  def seasonal_domain_params
    params.require(:seasonal_domain).permit(:name, :subdomain)
  end

  def find_seasonaldomain
    @seasonal_domain = SeasonalDomain.find(params[:id])
  end

end
