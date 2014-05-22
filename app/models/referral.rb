class Referral < ActiveRecord::Base

  default_scope -> { order('created_at DESC') }
  validates :company_id, presence: true
  validates :details, presence: true, length: { maximum: 140 }
  validates :link, presence: true, format: { with: URI.regexp }

  belongs_to :company
  has_many :claims, dependent: :destroy

  before_validation :add_http
  after_create :create_claim

  self.per_page = 10

  def update_rank
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = (self.claims.count - 1) + age

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

  private

  def create_claim
    self.claims.create
  end

  def add_http
    unless self.link.start_with?('http') || self.link.start_with?('https') || self.link.empty?
      orig_link = self.link
      self.link = "http://#{orig_link}"
    end
  end
end
