
UIDemo.app.on 'application:setup', (world) ->
  world.productCategories = new UIDemo.Collections.ProductCategories

UIDemo.app.on 'application:initialize', (world) ->
  productsView = new UIDemo.View.ProductCategories
    collection: world.productCategories
  $('body').append productsView.render().el

  new UIDemo.Routers.CategoryRouter

