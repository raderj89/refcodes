# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Company < ApplicationRecord
  has_many :referrals, dependent: :destroy

  validates :name, presence: true, length: { maximum: 25 }
end
