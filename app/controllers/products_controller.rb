class ProductsController < ApplicationController
  respond_to :html, :json

  before_filter :get_resource_collection

  def index
    @products = @collection.all
    sleep 3

    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  def show
    @product = @collection.find params[:id]
    sleep 3
    respond_with @product
  end

  def details
    @product = @collection.find params[:product_id]
    sleep 3
    respond_with @product, serializer: ProductDetailsSerializer
  end

  private

  def get_resource_collection
    @collection = Product
    if params[:product_category_id].present?
      @product_category = ProductCategory.find(params[:product_category_id])
      @collection = @product_category.products
    end
  end

end
