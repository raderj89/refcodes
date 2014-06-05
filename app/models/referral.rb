class Referral < ActiveRecord::Base

  validates :company_id, presence: true
  validates :details, presence: true, length: { maximum: 140 }

  default_scope -> { joins(:company).includes(:claims).order('rank DESC') }
  
  scope :latest, -> { joins(:company).includes(:claims).order('created_at DESC') }

  scope :all_time, -> { find_by_sql("SELECT referrals.*, COUNT(claims.id) AS num_claims FROM referrals
                                      JOIN claims ON claims.referral_id = referrals.id
                                     GROUP BY referrals.id ORDER BY num_claims DESC") }

  belongs_to :company
  has_many :claims, dependent: :destroy
  
  after_create :create_claim
  after_create :add_http

  self.per_page = 10

  def update_rank
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = (self.claims.count - 1) + age
    self.update(rank: new_rank)
  end

  include PgSearch

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

  private

  def create_claim
    self.claims.create
  end

  def add_http
    unless self.link.start_with?('http') || self.link.start_with?('https')
      orig_link = self.link
      self.link = "http://#{orig_link}"
      self.save!
    end
  end
end
