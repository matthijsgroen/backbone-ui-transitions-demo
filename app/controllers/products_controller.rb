class ProductsController < ApplicationController
  respond_to :html, :json

  before_filter :get_resource_collection

  def index
    @products = @collection.all
    sleep 2

    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  def show
    @product = @collection.find params[:id]
    respond_with @product
  end

  private

  def get_resource_collection
    @collection = Product
    @collection = ProductCategory.find(params[:product_category_id]).products if params[:product_category_id].present?
  end

end
