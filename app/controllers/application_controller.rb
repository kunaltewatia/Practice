# Application controller
class ApplicationController < ActionController::Base
  include UrlHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  layout :layout_by_resource

  protected

  def layout_by_resource
    return 'devise' if devise_controller?
    return 'app' if params[:controller] == 'home' || params[:controller] == 'pay_u_money'
    'application'
  end

  def pagination_params
    @page = params[:page] || PAGE
    @per_page = params[:per_page] || PER_PAGE
  end

  def after_sign_in_path_for(resource)
    '/admin'
  end

  def after_sign_out_path_for(resource_or_scope)
    '/admin'
  end
end
