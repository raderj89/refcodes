require 'rails_helper'

describe "Referral pages", type: :feature do
  let!(:company) { FactoryGirl.create(:company) }

  let!(:r1) do
    FactoryGirl.create(:referral,
      company: company,
      details: "Lorem ipsum",
      link: "http://example.com",
      claim_count: 2)
  end

  let!(:r2) do
    FactoryGirl.create(:referral,
      company: company,
      details: "Lorem ipsum et",
      link: "http://example2.com",
      claim_count: 4)
  end

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
      it { should have_content(r1.claim_count) }
      it { should have_content(r2.claim_count) }
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
        expect(r1.claim_count).to eq 2

        first('.claim-ref').click

        expect(r1.reload.claim_count).to eq 3
      end
    end

    describe "delete links" do
      it { should_not have_css('.admin-controls') }

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
