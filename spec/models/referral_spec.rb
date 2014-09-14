require 'spec_helper'

describe Referral do
  let(:company) { FactoryGirl.create(:company) }
  let(:referral) { FactoryGirl.create(:referral) }

  subject { referral }

  it { should respond_to(:details) }
  it { should respond_to(:link) }
  it { should respond_to(:company_id) }
  it { should respond_to(:claims) }
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

  describe "claim associations" do
    let!(:first_claim) do
      FactoryGirl.create(:claim, referral: referral)
    end

    let!(:second_claim) do
      FactoryGirl.create(:claim, referral: referral)
    end

    it "should destroy associated claims" do
      claims = referral.claims.to_a

      referral.destroy

      expect(claims).not_to be_empty

      claims.each do |claim|
        expect(Claim.where(id: claim.id)).to be_empty
      end
    end
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
