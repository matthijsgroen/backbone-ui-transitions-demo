# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_category do
    name { Faker::Company.name }
    sequence(:image_url) { |n| "http://placezombies.com/100x100?#{n}" }
  end
end
