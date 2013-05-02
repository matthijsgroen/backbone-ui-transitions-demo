class ProductSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :name, :image_url, :detail_image_url
  attribute :image_url, key: 'imageUrl'
  attribute :detail_image_url, key: 'detailImageUrl'
end
