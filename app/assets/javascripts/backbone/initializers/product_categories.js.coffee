
UIDemo.app.on 'application:setup', (world) ->
  world.productCategories = new UIDemo.Collections.ProductCategories

UIDemo.app.on 'application:initialize', (world) ->
  productsView = new UIDemo.Views.ProductCategoriesView
    collection: world.productCategories
  $('body').append productsView.render().el

  new UIDemo.Routers.CategoryRouter
    view: productsView
    collection: world.productCategories

