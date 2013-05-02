# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_category do
    name { Faker::Company.name }
    sequence(:image_url) do |index|
      categories = %w(abstract animals business cats city food nightlife fashion people nature sports technics transport)
      image_index = ((index - 1) / categories.length) + 1
      "http://lorempixel.com/100/100/#{categories[(index - 1) % categories.length]}/#{image_index}"
    end
  end
end
