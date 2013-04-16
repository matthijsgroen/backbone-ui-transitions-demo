class UIDemo.Models.Product extends Backbone.Model

class UIDemo.Collections.Products extends Backbone.Collection

  model: UIDemo.Models.Product

  url: ->
    "/categories/#{@categoryId}/products.json"

  initialize: (models, { @categoryId }) ->

  parse: (response) ->
    response['products']
