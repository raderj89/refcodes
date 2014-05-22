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
  it { should belong_to(:company) }



  it { should respond_to(:claims) }
  it { should be_valid }

  describe "when details are not present" do
    before { @referral.details = " " }
    it { should_not be_valid }
  end

  describe "when link is not present" do
    before { @referral.link = "" }
    it { should_not be_valid }
  end

  # TODO: create better link format test
  # describe "when link format is incorrect" do
  #   before { @referral.link = "example" }
  #   it { should_not be_valid }
  # end

  describe "when details are too long" do
    before { @referral.details = "This is way too long." * 50 }
    it { should_not be_valid }
  end

  describe "when company_id is not present" do
    before { @referral.company_id = nil }
    it { should_not be_valid }
  end

  describe "claim associations" do
    before { @referral.save }

    let!(:first_claim) do
      FactoryGirl.create(:claim, referral: @referral)
    end
    let!(:second_claim) do
      FactoryGirl.create(:claim, referral: @referral)
    end

    it "should destroy associated claims" do
      claims = @referral.claims.to_a

      @referral.destroy

      expect(claims).not_to be_empty
      claims.each do |claim|
        expect(Claim.where(id: claim.id)).to be_empty
      end
    end
  end
end
