# ComplaintCategoriesController
class ComplaintCategoriesController < ApplicationController
  before_action :set_complaint_category, only: [:show, :edit, :update, :destroy]
  before_action :pagination_params, only: [:index]

  def index
    @complaint_categories = ComplaintCategory.paginate(page: @page,
                                                       per_page: @per_page)
  end

  def new
    @complaint_category = ComplaintCategory.new
  end

  def create
    @complaint_category = ComplaintCategory.new(complaint_category_params)
    if @complaint_category.save
      redirect_to complaint_categories_url,
                  notice: 'Complaint category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @complaint_category.update(complaint_category_params)
      redirect_to complaint_categories_url,
                  notice: 'Complaint category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /complaint_categories/1
  # DELETE /complaint_categories/1.json
  def destroy
    @complaint_category.destroy
    redirect_to complaint_categories_url,
                notice: 'Complaint category was successfully destroyed.'
  end

  private

  def set_complaint_category
    @complaint_category = ComplaintCategory.find(params[:id])
  end

  def complaint_category_params
    params.require(:complaint_category).permit(:id, :name,
                                               :description, :is_active)
  end
end
