FactoryGirl.define do

  factory :company do
    name  "Bloc"
  end

  factory :referral do
    company
    details "Lorem ipsum"
    link    "http://example.com"
    after :build do |claim, ev|
      referral.claims << build(:claim)
  end

  factory :claim do
    referral
  end
end