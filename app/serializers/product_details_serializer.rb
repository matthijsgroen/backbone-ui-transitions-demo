class ProductDetailsSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :name, :image_url, :description
  attribute :image_url, key: 'imageUrl'
end

