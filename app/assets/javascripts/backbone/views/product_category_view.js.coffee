
class UIDemo.Views.ProductCategoryView extends Backbone.View
  tagName: 'li'
  className: 'category'

  template: JST['product_category']

  render: ->
    @$el.html @template this
    this

  activate: ->
    alert 'TODO: Implement activate on ProductCategoryView'

  categoryUrl: ->
    "#categories/#{@model.id}"

  categoryImageUrl: ->
    @model.get 'image_url'

