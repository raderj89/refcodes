class Company < ActiveRecord::Base
  has_many :referrals, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 25 }
end
