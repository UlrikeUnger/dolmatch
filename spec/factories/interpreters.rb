FactoryGirl.define do
  factory :interpreter do
    confirmed_at { Time.now }
    name  { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    after(:build) do |interpreter|
      interpreter.language_skills << create(:language_skill, interpreter: interpreter)
    end
  end
end
