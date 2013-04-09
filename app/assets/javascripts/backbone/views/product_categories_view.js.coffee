
class UIDemo.Views.ProductCategoriesView extends Backbone.View
  tagName: 'section'
  className: 'products'

  template: JST['product_categories']

  render: ->
    @$el.html template this
    this

