class Referral < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  validates :details, presence: true
  validates :link, presence: true, url: true
end
