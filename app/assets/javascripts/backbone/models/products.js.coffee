class UIDemo.Models.Product extends Backbone.Model

  detailUrl: ->
    "/categories/#{@collection.categoryId}/products/#{@id}/details.json"

  fetchDetails: ->
    return `when`.resolve(this) if @get('description')?
    promise = @fetch(url: @detailUrl())
    `when(promise)`.then =>
      this

class UIDemo.Collections.Products extends Backbone.Collection

  model: UIDemo.Models.Product

  url: ->
    "/categories/#{@categoryId}/products.json"

  initialize: (models, { @categoryId }) ->

  parse: (response) ->
    response['products']


