FactoryGirl.define do
  factory :address do
    zip  { Faker::Address.postcode }
    city { Faker::Address.city }
  end
end
