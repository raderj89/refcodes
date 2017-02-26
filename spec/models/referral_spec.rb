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

require 'rails_helper'

describe Referral do
  let(:company) { FactoryGirl.create(:company) }

  subject(:referral) { FactoryGirl.create(:referral) }

  it { should respond_to(:details) }
  it { should respond_to(:link) }
  it { should respond_to(:company_id) }
  it { should be_valid }

  describe "when details are not present" do
    before { referral.details = " " }
    it { should_not be_valid }
  end

  describe "when link is not present" do
    before { referral.link = " " }
    it { should_not be_valid }
  end

  describe "when link doesn't begin with http://" do
    before { referral.link = "example.com" }

    it "adds http:// to beginning of link" do
      referral.save

      expect(referral.link).to eq "http://example.com"
    end

    it { should be_valid }
  end

  describe "when details are too long" do
    before { referral.details = "This is way too long." * 50 }
    it { should_not be_valid }
  end

  describe "when company_id is not present" do
    before { referral.company_id = nil }
    it { should_not be_valid }
  end

  describe '#increment_claim_count' do
    it 'increments the claim count by 1' do
      expect(referral.claim_count).to eq 0

      referral.increment_claim_count

      expect(referral.claim_count).to eq 1
    end

    it 'updates the rank' do
      expect(referral.rank).to be nil

      referral.increment_claim_count

      expect(referral.rank).to eq expected_rank(referral)
    end
  end

  def expected_rank(referral)
    age = (referral.created_at - Time.new(1970,1,1)) / 86400
    (referral.claim_count - 1) + age
  end

  describe "when associated company is deleted" do
    let!(:referral1) do
      FactoryGirl.create(:referral, company: company)
    end

    let!(:referral2) do
      FactoryGirl.create(:referral, company: company)
    end

    it "should destroy the associated referrals" do
      referrals = company.referrals.to_a

      company.destroy

      expect(referrals).not_to be_empty

      referrals.each do |referral|
        expect(Referral.where(id: referral.id)).to be_empty
      end
    end
  end
end
