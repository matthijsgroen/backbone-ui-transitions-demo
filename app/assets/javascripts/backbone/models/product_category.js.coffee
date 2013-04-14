
class UIDemo.Models.ProductCategory extends Backbone.Model

  initialize: ->
    @products = new UIDemo.Collections.Products(
      []
      categoryId: @id
    )

  loadProducts: ->
    if @products.length isnt 0
      return `when`.resolve @products

    @trigger 'products:loading'
    p = @products.fetch()
    `when(p)`.then =>
      @trigger 'products:loaded', this, @products
      @products

class UIDemo.Collections.ProductCategories extends Backbone.Collection

  model: UIDemo.Models.ProductCategory

