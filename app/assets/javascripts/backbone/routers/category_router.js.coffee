
class UIDemo.Routers.CategoryRouter extends Backbone.Router
  routes:
    'categories/:id': 'show'
    '': 'index'

  initialize: ({ @view, @collection }) ->

  index: ->
    @view.closeAll()

  show: (id) ->
    category = @collection.get(id)
    category.loadProducts().then (products) =>
      @view.open(id)

