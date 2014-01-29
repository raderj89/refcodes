require 'spec_helper'

describe "Referral pages" do
  
  subject { page }

  describe "referrals page" do
    let(:company) { FactoryGirl.create(:company) }
    let!(:r1) { FactoryGirl.create(:referral, company: company, details: "Lorem ipsum", link: "http://example.com") }
    let!(:r2) { FactoryGirl.create(:referral, company: company, details: "Lorem ipsum et", link: "http://example2.com") }
    before { visit root_path }

    it { should have_content('Refcodes') }
    it { should have_title('Refcodes') }

    describe "referrals" do
      it { should have_content(r1.company.name) }
      it { should have_content(r1.details) }
      it { should have_content(r1.link) }
      it { should have_content(r2.company.name) }
      it { should have_content(r2.details) }
      it { should have_content(r2.link) }
    end

    describe "referral creation" do
      before { visit root_path }

      describe "with invalid information" do

        it "should not create a referral" do
          expect { click_button "Submit" }.not_to change(Referral, :count)
        end

        describe "error messages" do
          before { click_button "Submit" }
          it { should have_content('error') }
        end
      end

      describe "with valid information" do

        before { fill_in 'company_name', with: "Bloc" }
        before { fill_in 'referral_details', with: "Lorem ipsum" }
        before { fill_in 'referral_link', with: "http://example.com" }
        it "should create a referral" do
          expect { click_button "Submit" }.to change(Referral, :count).by(1)
        end
      end
    end
  end
end
