class Claim < ActiveRecord::Base
  belongs_to :referral

  validates :referral_id, presence: true
end
