FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Commerce.price(range: 1..100) }
    association :merchant
  end
end


# FactoryBot.define do
#   factory :item do
#     sequence(:name) { |n| "Item #{n}" }
#     description { "This is a test item." }
#     unit_price { 75.0 } # Set a fixed price in the expected range
#     association :merchant
#   end
# end