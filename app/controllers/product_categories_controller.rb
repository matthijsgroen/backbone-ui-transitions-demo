class ProductCategoriesController < ApplicationController

  def index
    @product_categories = ProductCategory.all
  end

end

