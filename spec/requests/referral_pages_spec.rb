require 'rails_helper'

describe "Referral pages" do
  let!(:company) { FactoryGirl.create(:company) }
  
  let!(:r1) do
    FactoryGirl.create(:referral,
      company: company,
      details: "Lorem ipsum",
      link: "http://example.com")
  end
  
  let!(:r2) do
    FactoryGirl.create(:referral,
      company: company,
      details: "Lorem ipsum et",
      link: "http://example2.com")
  end

  let!(:c1) { FactoryGirl.create(:claim, referral: r1) }
  let!(:c2) { FactoryGirl.create(:claim, referral: r2) }

  subject { page }

  describe "referrals index page" do
    
    before { visit root_path }

    it { should have_title('Refcodes') }

    describe "referrals" do
      it { should have_content(r1.company.name) }
      it { should have_content(r1.details) }
      it { should have_content(r1.link) }
      it { should have_content(r2.company.name) }
      it { should have_content(r2.details) }
      it { should have_content(r2.link) }
      it { should have_content(r1.claims.count) }
      it { should have_content(r2.claims.count) }
    end

    describe "referral creation" do
      describe "with invalid information" do

        it "should not create a referral" do
          expect { click_button "Submit" }.not_to change(Referral, :count)
        end

        describe "error messages" do
          before { click_button "Submit" }
          
          it { should have_css('#error-explanation') }
        end
      end

      describe "with valid information" do

        before do
          fill_in 'Company Name', with: "Bloc"
          fill_in 'Discount Details', with: "Lorem ipsum"
          fill_in 'Link', with: "http://example.com"
        end

        it "should create a referral" do
          expect { click_button "Submit" }.to change(Referral, :count).by(1)
        end
      end
    end

    describe "claim creation" do
      it "should increase claims count when clicked" do
        expect{ first('.claim-ref').click }.to change(Claim, :count).by(1)
      end
    end

    describe "delete links" do
      it { should_not have_css('.admin-controls')}

      describe "as an admin" do
        let(:admin) { FactoryGirl.create(:admin) }

        before do
          login_as admin, scope: :admin
          visit root_path
        end

        it { should have_css('.admin-controls') }

        it "should be able to delete a referral" do
          expect {
            click_button('Delete', match: :first)
          }.to change(Referral, :count).by(-1)
        end

        it { should have_link('Edit', href: edit_referral_path(r2)) }
      end
    end
  end

  describe "referral show page" do
    before { visit referral_path(r1) }

    it { should have_content(r1.company.name) }
  end
end
