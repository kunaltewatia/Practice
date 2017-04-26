# Invitation Controller
class InvitationsController < ApplicationController
  protect_from_forgery
  before_filter :authenticate_user!, except: [:index, :create]
  layout false

  def index
  end

  def create
    @invite = Invitation.find_by(mobile_number: params[:mobile_number])
    if @invite.nil?
      @invite = Invitation.new(mobile_number: params[:mobile_number])
    else
      @invite.count += 1
    end
    render_text
  end

  private

  def render_text
    if @invite.save
      render json: { message: 'Invitation has been sent' }
    else
      render json: { message: 'Mobile Number should be 10 digit' },
             status: :precondition_failed
    end
  end
end
