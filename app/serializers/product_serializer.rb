class ProductSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :name, :image_url
  attribute :image_url, key: 'imageUrl'
end
