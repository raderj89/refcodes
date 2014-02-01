class Referral < ActiveRecord::Base
  scope :most_popular, -> { order('rank DESC') }
  default_scope -> { order('created_at DESC') }
  validates :company_id, presence: true
  validates :details, presence: true, length: { maximum: 140 }
  validates :link, presence: true, url: true

  belongs_to :company
  has_many :claims, dependent: :destroy

  self.per_page = 3

  def update_rank
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = self.claims.count + age

    self.update_attribute(:rank, new_rank)
  end

  include PgSearch

  pg_search_scope :search, against: [:details],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {company: :name}

  def self.text_search(query)
    if query.present?
      search(query)
    else
      all
    end
  end
end
