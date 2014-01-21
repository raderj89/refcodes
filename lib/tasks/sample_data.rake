namespace :db do
  task populate: :environment do

    company_list = ["Bloc", "Team Treehouse", "One Month Rails", "Thinkful", "Skillshare", "Dropbox", "Uber"]

    25.times do
      company = Company.create!(name: company_list.sample)
      company.referrals.create!(
                      details: "$100 off a really sweet deal!",
                      link: "https://www.bloc.io/?ref_token=OTU3NzA"
                      )
    end
  end
end