class ProductCategory < ActiveRecord::Base
  attr_accessible :image_url, :name
  has_many :products, foreign_key: 'category_id'
end
