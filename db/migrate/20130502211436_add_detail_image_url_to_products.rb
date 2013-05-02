class AddDetailImageUrlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :detail_image_url, :string
  end
end
