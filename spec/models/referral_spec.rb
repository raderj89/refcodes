require 'spec_helper'

describe Referral do

  let(:company) { FactoryGirl.create(:company) }
  
  before do
    @referral = company.referrals.build(details: "Lorem ipsum", link: "http://example.com")
    @referrals = Referral.all
  end

  subject { @referral }

  it { should respond_to(:details) }
  it { should respond_to(:link) }
  it { should respond_to(:company_id) }
  it { should respond_to(:claims) }
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

  describe "when details are too long" do
    before { @referral.details = "This is way too long." * 50 }
    it { should_not be_valid }
  end

end
