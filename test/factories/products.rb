# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraphs.join "\n\n" }
    sequence(:image_url) { |i| "http://lorempixel.com/150/200?#{i}" }
    price 1.5
  end
end
