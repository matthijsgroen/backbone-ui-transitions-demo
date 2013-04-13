
class UIDemo.Routers.CategoryRouter extends Backbone.Router
  routes:
    'categories/:id': 'show'

  initialize: ({ @view, @collection }) ->

  show: (id) ->
    category = @collection.get(id)
    category.loadProducts().then =>
      @view.open(id)
    .then null,
      (error) -> console.log error.message

