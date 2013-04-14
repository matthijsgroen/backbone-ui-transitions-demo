
class UIDemo.Routers.CategoryRouter extends Backbone.Router
  routes:
    'categories/:id': 'show'
    '': 'index'

  initialize: ({ @categoriesView }) ->

  index: ->
    @categoriesView.closeAll()

  show: (id) ->
    @categoriesView.open id

