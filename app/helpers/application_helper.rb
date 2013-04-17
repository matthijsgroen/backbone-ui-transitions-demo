module ApplicationHelper

  def product_categories_json
    serialize_json_array((@product_categories || ProductCategory.all), ProductCategorySerializer)
  end

  def product_category_products_json
    serialize_json_array(@product_category.products, ProductSerializer)
  end

  private

  def serialize_json_array(list, serializer)
    "[" << list.map { |model| serializer.new(model).to_json }.join(',') << "]"
  end
end
