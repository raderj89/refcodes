class Claim < ActiveRecord::Base
  belongs_to :referral

  validates :referral_id, presence: true

  after_create :update_referral

  private

  def update_referral
    self.referral.update_rank
  end
end
