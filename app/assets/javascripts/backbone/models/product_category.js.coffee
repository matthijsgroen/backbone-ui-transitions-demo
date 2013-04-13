
class UIDemo.Models.ProductCategory extends Backbone.Model

  initialize: ->
    @products = new UIDemo.Collections.Products

  loadProducts: ->
    defer = `when`.defer()
    @trigger 'products:loading'
    setTimeout(
      =>
        @products.reset([
          { name: 'hello1', imageUrl: 'http://lorempixel.com/150/200?1' }
          { name: 'hello2', imageUrl: 'http://lorempixel.com/150/200?2' }
          { name: 'hello3', imageUrl: 'http://lorempixel.com/150/200?3' }
          { name: 'hello4', imageUrl: 'http://lorempixel.com/150/200?4' }
          { name: 'hello5', imageUrl: 'http://lorempixel.com/150/200?5' }
          { name: 'hello6', imageUrl: 'http://lorempixel.com/150/200?10' }
          { name: 'hello7', imageUrl: 'http://lorempixel.com/150/200?13' }
        ])
        @trigger 'products:loaded', this, @products
        defer.resolve(@products)
      1200
    )
    defer.promise

class UIDemo.Collections.ProductCategories extends Backbone.Collection

  model: UIDemo.Models.ProductCategory

