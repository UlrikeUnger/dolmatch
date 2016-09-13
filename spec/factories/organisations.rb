FactoryGirl.define do
  factory :organisation do
    confirmed_at { Time.now }
    name  { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
