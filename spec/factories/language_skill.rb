FactoryGirl.define do
  factory :language_skill do
    level {  %w[conversational intermediate profi business_fluent mother_tongue].sample }
    locale { [:de, :en].sample }
  end
end
