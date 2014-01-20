require 'spec_helper'

describe Referral do

  before do
    @referral = Referral.new(details: "Lorem ipsum", link: "http://example.com")
    @referrals = Referral.all
  end

  subject { @referral }

  it { should respond_to(:details) }
  it { should respond_to(:link) }
  it { should be_valid }

  describe "when details are not present" do
    before { @referral.details = " " }
    it { should_not be_valid }
  end

  describe "when link is not present" do
    before { @referral.link = " " }
    it { should_not be_valid }
  end

  describe "when link format is incorrect" do
    before { @referral.link = "example" }
    it { should_not be_valid }
  end

  describe "order" do
    let!(:older_referral) do
      FactoryGirl.create(:referral, created_at: 1.day.ago)
    end
    let!(:newer_referral) do
      FactoryGirl.create(:referral, created_at: 1.hour.ago)
    end

    it "should have the right referrals in the right order" do
      expect(@referrals).to eq [newer_referral, older_referral]
    end
  end
end
