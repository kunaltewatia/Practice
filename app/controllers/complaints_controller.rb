# ComplaintsController
class ComplaintsController < ApplicationController
  before_action :set_complaint, only: [:show, :edit, :update, :destroy]
  # before_action :pagination_params, only: [:index]
  before_action :set_category, only: [:edit, :new, :create]

  def new
    @complaint = Complaint.new
  end

  def index
    @resolved = Complaint.closed.order(created_at: :desc)
    @opened = Complaint.opened.order(created_at: :desc)
    @accepted = Complaint.accepted.order(created_at: :desc)
  end

  def create
    @complaint = Complaint.new(complaint_params)
    if @complaint.save
      redirect_to complaints_url, notice: 'Complaint was successfully updated.'
    else
      render :edit
    end
  end

  def update
    if @complaint.update(complaint_params)
      redirect_to complaints_url, notice: 'Complaint was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @complaint.destroy
    redirect_to complaints_url, notice: 'Complaint was successfully destroyed.'
  end

  private

  def set_category
    @categories = ComplaintCategory.select('id', 'name').active
    @orders = Order.all
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_complaint
    @complaint = Complaint.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the
  # white list through.
  def complaint_params
    params.require(:complaint)
      .permit(:mobile_user_id, :user_id, :complaint_category_id,
              :text, :admin_comment, :status, :is_extra_fruit, :is_resolved,
              :date, :fruit_name, :image, :order_id, :txt_id)
  end
end
