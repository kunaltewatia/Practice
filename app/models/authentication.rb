# Authentication model
class Authentication < ActiveRecord::Base
  belongs_to :mobile_user

  validates :mobile_user_id, :uuid, :auth_token, presence: true
  validates_uniqueness_of :uuid, scope: [:mobile_user_id]
  after_create :set_os

  private

  def set_os
    update_attribute(:os, 'android') if os.nil?
  end
end
