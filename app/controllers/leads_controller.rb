# LeadsController
class LeadsController < ApplicationController
  before_action :set_leads, only: [:edit, :update, :destroy]

  def index
    @leads = Lead.paginate(page: @page, per_page: @per_page)
  end
end
