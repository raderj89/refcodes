class Referral < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  validates :company_id, presence: true
  validates :details, presence: true, length: { maximum: 140 }
  validates :link, presence: true, url: true

  belongs_to :company
  has_many :claims, dependent: :destroy

  self.per_page = 10
end
