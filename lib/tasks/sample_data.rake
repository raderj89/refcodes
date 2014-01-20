namespace :db do
  task populate: :environment do
    25.times do
      Referral.create!(details: "$100 off Bloc web dev course",
                       link: "https://www.bloc.io/?ref_token=OTU3NzA" 
                      )
    end
  end
end