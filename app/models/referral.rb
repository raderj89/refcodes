class Referral < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  validates :details, presence: true, length: { maximum: 140 }
  validates :link, presence: true, url: true

  belongs_to :company
end
