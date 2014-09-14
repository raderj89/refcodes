class Referral < ActiveRecord::Base
  include PgSearch

  validates :company, presence: true
  validates :details, presence: true, length: { maximum: 140 }
  validates :link, presence: true, url: true

  belongs_to :company, inverse_of: :referrals
  has_many :claims, dependent: :destroy
  
  accepts_nested_attributes_for :company

  before_validation :add_http_if_none
  after_create :create_claim

  scope :trending, -> { joins(:company).includes(:claims).order('rank DESC') }
  scope :latest, -> { joins(:company).includes(:claims).order('created_at DESC') }
  scope :all_time, -> { find_by_sql("SELECT referrals.*, COUNT(claims.id) AS num_claims FROM referrals
                                      JOIN claims ON claims.referral_id = referrals.id
                                     GROUP BY referrals.id ORDER BY num_claims DESC") }

  # Pagination
  self.per_page = 10

  # PG Search
  pg_search_scope :search, against: [:details],
    using: { tsearch: { dictionary: "english" } },
    associated_against: { company: :name }

  def self.text_search(query)
    if query.present?
      search(query)
    else
      all
    end
  end

  def update_rank
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = (self.claims.count - 1) + age
    self.update(rank: new_rank)
  end

  private

  def create_claim
    self.claims.create
  end

  def add_http_if_none
    unless self.link.start_with?('http') || self.link.start_with?('https')
      original_link = self.link
      self.link = "http://#{original_link}"
    end
  end
end
