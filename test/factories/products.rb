# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraphs.join "\n\n" }
    sequence(:image_url) do |index|
      categories = %w(abstract animals business cats city food nightlife fashion people nature sports technics transport)
      image_index = ((index - 1) % 8) + 1
      category_index = (index - 1) / 8
      "http://lorempixel.com/150/200/#{categories[category_index]}/#{image_index}"
    end
    sequence(:detail_image_url) do |index|
      categories = %w(abstract animals business cats city food nightlife fashion people nature sports technics transport)
      image_index = ((index - 1) % 8) + 1
      category_index = (index - 1) / 8
      "http://lorempixel.com/375/500/#{categories[category_index]}/#{image_index}"
    end
    price 1.5
  end
end
