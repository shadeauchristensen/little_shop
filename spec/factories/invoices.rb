FactoryBot.define do
  factory :invoice do
    status { Faker::Subscription.status }
    association :merchant, :customer
  end
end