# Pack Controller
class PacksController < ApplicationController
  before_action :set_pack, only: [:show, :edit, :update, :destroy]
  before_action :set_services, except: [:index, :destroy]
  before_action :pagination_params, only: [:index]

  def index
    @packs = Pack.paginate(page: @page, per_page: @per_page)
  end

  def new
    @pack = Pack.new
  end

  def create
    @pack = Pack.new(pack_params)

    respond_to do |format|
      if @pack.save
        format.html do
          redirect_to packs_url, notice: 'Pack was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @pack.update(pack_params)
        format.html do
          redirect_to packs_url, notice: 'Pack was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @pack.destroy
    respond_to do |format|
      format.html do
        redirect_to packs_url, notice: 'Pack was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pack
    @pack = Pack.find(params[:id])
  end

  def set_services
    @services = Service.select('id', 'name')
  end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def pack_params
    params.require(:pack).permit(:service_id, :name, :description, :is_active, :is_visible)
  end
end
