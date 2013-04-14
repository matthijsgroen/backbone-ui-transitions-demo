class UIDemo.Models.Product extends Backbone.Model

class UIDemo.Collections.Products extends Backbone.Collection

  model: UIDemo.Models.Product

  url: ->
    "/product_categories/#{@categoryId}/products.json"

  initialize: ({ @categoryId }) ->

  parse: (response) ->
    response['products']
