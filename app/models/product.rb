class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :name, :price
  belongs_to :category, class_name: 'ProductCategory'
end
