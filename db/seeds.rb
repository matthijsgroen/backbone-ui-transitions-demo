# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
puts "-- Seeding fake product and category data"

start_time = Time.now

FactoryGirl.create_list(:product_category, 30).each do |category|
  FactoryGirl.create_list(:product, 8, category: category)
end

puts "   -> #{"%.4f" % (Time.now - start_time)}s"

