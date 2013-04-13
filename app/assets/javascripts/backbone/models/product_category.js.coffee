
class UIDemo.Models.ProductCategory extends Backbone.Model

  initialize: ->
    @products = new UIDemo.Collections.Products

  loadProducts: ->
    defer = `when`.defer()
    @trigger 'products:loading'
    setTimeout(
      =>
        @products.reset([
          {}
          {}
          {}
          {}
          {}
        ])
        @trigger 'products:loaded', this, @products
        defer.resolve(@products)
      1200
    )
    defer.promise

class UIDemo.Collections.ProductCategories extends Backbone.Collection

  model: UIDemo.Models.ProductCategory

