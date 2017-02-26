FactoryGirl.define do

  factory :company do
    name  "Bloc"
  end

  factory :referral do
    company
    details "Lorem ipsum"
    link    "http://example.com"
  end

  factory :admin do
    email "admin@example.com"
    password "helloworld"
    password_confirmation "helloworld"
  end
end
