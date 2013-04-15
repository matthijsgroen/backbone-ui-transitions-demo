
class UIDemo.Routers.ProductRouter extends Backbone.Router

  routes:
    'categories/:categoryId/products/:id': 'show'

  initialize: ({ @categoriesView }) ->

  show: (categoryId, id) ->
    @categoriesView.open(categoryId).then (categoryProductsView) =>
      categoryProductsView.openProduct(id)

