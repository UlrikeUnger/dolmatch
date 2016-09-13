FactoryGirl.define do
  factory :appointment do
    venue { Faker::Address.street_address }
    title { Faker::Lorem.word }
    kind { Appointment::KINDS.sample }
    date_at { Faker::Date.between(Date.today, 7.days.from_now) }
    language_from ['de', 'en'].sample
    language_to ['de', 'en'].sample
    start_time_at { Faker::Time.between(DateTime.now, DateTime.now + 7) }

    organisation
    address

    trait :created do
      organisation { create(:organisation, confirmed_at: nil) }

      state :created
    end

    trait :available do
      state :available
    end

    trait :assigned do
      state :assigned

      interpreter
    end

    trait :done do
      assigned

      state :done
    end
  end
end
