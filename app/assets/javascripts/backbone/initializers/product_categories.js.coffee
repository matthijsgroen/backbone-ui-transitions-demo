
UIDemo.app.on 'application:setup', (world) ->
  world.productCategories = new UIDemo.Collections.ProductCategories

UIDemo.app.on 'application:initialize', (world) ->
  categoriesView = new UIDemo.Views.ProductCategoriesView
    collection: world.productCategories
  $('body').append categoriesView.render().el

  new UIDemo.Routers.CategoryRouter
    categoriesView: categoriesView

  new UIDemo.Routers.ProductRouter
    categoriesView: categoriesView

