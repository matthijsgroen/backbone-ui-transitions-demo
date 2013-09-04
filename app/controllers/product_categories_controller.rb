class ProductCategoriesController < ApplicationController
  respond_to :html, :json

  def index
    @product_categories = ProductCategory.all
    sleep 3
    respond_to do |format|
      format.html
      format.json { render json: @product_categories }
    end
  end

  def show
    @product_category = ProductCategory.find(params[:id])
    sleep 3
    respond_with @product_category
  end

end

