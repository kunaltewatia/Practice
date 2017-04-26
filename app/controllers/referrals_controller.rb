# ReferralsController
class ReferralsController < ApplicationController
  before_action :set_referral, only: [:show, :edit, :update, :destroy]

  def index
    @converted = Referral.converted.order(created_at: :desc)
    @waited = Referral.waited.order(created_at: :desc)
  end

  def new
    @referral = Referral.new
  end

  def create
    @referral = Referral.new(referral_params)
    if @referral.save
      redirect_to referrals_url, notice: 'Referral was successfully created.'
    else
      render :new
    end
  end

  def update
    if @referral.update(referral_params)
      redirect_to referrals_url, notice: 'Referral was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @referral.destroy
    redirect_to referrals_url, notice: 'Referral was successfully destroyed.'
  end

  private

  def set_referral
    @referral = Referral.find(params[:id])
  end

  def referral_params
    params.require(:referral).permit(:mobile_user_id, :contact, :is_converted)
  end
end
