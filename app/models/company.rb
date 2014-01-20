class Company < ActiveRecord::Base
  has_many :referrals, dependent: :destroy
end
