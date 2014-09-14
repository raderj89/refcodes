require 'spec_helper'

describe Company do
  let(:company) { FactoryGirl.create(:company) }

  subject { company }

  it { should respond_to(:name) }
  it { should be_valid }
  it { should respond_to(:referrals)}

  describe "when name is not present" do
    before { company.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { company.name = "Bloc" * 50 }
    it { should_not be_valid }
  end

  describe "referral associations" do
    let!(:older_referral) do
      FactoryGirl.create(:referral, company: company, created_at: 1.day.ago)
    end
    
    let!(:newer_referral) do
      FactoryGirl.create(:referral, company: company, created_at: 1.hour.ago)
    end

    it "should have the right referrals in the right order" do
      expect(company.referrals.to_a).to eq [newer_referral, older_referral]
    end

    it "should destroy associated referrals" do
      referrals = company.referrals.to_a
  
      company.destroy
      expect(referrals).not_to be_empty
      referrals.each do |referral|
        expect(Referral.where(id: referral.id)).to be_empty
      end
    end
  end
end