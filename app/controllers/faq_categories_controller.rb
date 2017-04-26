# Controller for FAQ Category
class FaqCategoriesController < ApplicationController
  before_action :set_faq_category, only: [:show, :edit, :update, :destroy]
  before_action :set_service, except: [:destroy]
  before_action :pagination_params, only: [:index]

  def index
    @faq_categories = FaqCategory.paginate(page: @page, per_page: @per_page)
  end

  def show
  end

  def new
    @faq_category = FaqCategory.new
  end

  def edit
  end

  def create
    @faq_category = FaqCategory.new(faq_category_params)
    notice = 'Faq category was successfully created.'
    if @faq_category.save
      redirect_to @faq_category, notice: notice
    else
      render :new unless @faq_category.save
    end
  end

  def update
    notice = 'Faq category was successfully updated.'
    if @faq_category.update(faq_category_params)
      redirect_to @faq_category, notice: notice
    else
      render :edit
    end
  end

  def destroy
    @faq_category.destroy
    redirect_to faq_categories_url,
                notice: 'Faq category was successfully destroyed.'
  end

  private

  def set_faq_category
    @faq_category = FaqCategory.find(params[:id])
  end

  def faq_category_params
    params.require(:faq_category)
      .permit(
        :name, :service_id, :description, :is_active
      )
  end

  def set_service
    @services = Service.all
  end
end
