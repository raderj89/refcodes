# == Schema Information
#
# Table name: referrals
#
#  id          :integer          not null, primary key
#  details     :string(255)
#  link        :string(255)
#  code        :string(255)
#  expiration  :date
#  limit       :integer
#  created_at  :datetime
#  updated_at  :datetime
#  company_id  :integer
#  rank        :float
#  slug        :string(255)
#  claim_count :integer          default("0"), not null
#
# Indexes
#
#  index_referrals_on_company_id  (company_id)
#  index_referrals_on_slug        (slug) UNIQUE
#

class Referral < ApplicationRecord
  include PgSearch

  validates :company, presence: true
  validates :details, presence: true, length: { maximum: 140 }
  validates :link, presence: true, url: true

  belongs_to :company, inverse_of: :referrals

  accepts_nested_attributes_for :company

  before_validation :add_http_if_none

  scope :trending, -> { joins(:company).order(rank: :desc) }
  scope :latest, -> { joins(:company).order(created_at: :desc) }
  scope :all_time, -> { order(claim_count: :desc) }

  # Pagination
  self.per_page = 10

  # Friendly ID
  extend FriendlyId
  friendly_id :company_and_details, use: [:slugged, :finders]

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

  def increment_claim_count
    self.claim_count += 1
    save if update_rank
  end

  def update_rank
    age = (created_at - Time.new(1970,1,1)) / 86400
    self.rank = (claim_count - 1) + age
  end

  def empty_code?
    code.empty?
  end

  def company_name
    company.name
  end

  def nil_code?
    code.nil?
  end

  private

  def company_and_details
    "#{company.name} #{details}"
  end

  def add_http_if_none
    unless self.link.start_with?('http') || self.link.start_with?('https')
      original_link = self.link
      self.link = "http://#{original_link}"
    end
  end
end
