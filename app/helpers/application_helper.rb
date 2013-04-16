module ApplicationHelper

  def product_categories_json
    (@product_categories || ProductCategory.all).to_json(only: [:id, :name, :image_url])
  end

  def product_category_products_json
    @product_category.products.to_json(only: [:id, :name, :image_url])
  end
end
