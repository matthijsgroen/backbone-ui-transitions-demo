
class UIDemo.Routers.CategoryRouter extends Backbone.Router
  routes:
    'categories/:id': 'show'

  initialize: ({ @view }) ->

  show: (id) ->
    @view.open parseInt(id, 10)

