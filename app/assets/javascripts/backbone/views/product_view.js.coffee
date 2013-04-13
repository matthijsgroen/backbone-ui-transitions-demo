
class UIDemo.Views.ProductView extends Backbone.View
  tagName: 'li'
  className: 'product'
  template: JST['product']

  render: ->
    console.log 'stuff'
    @$el.html @template this
    this

  url: ->
    "#hello/stuff"

  imageUrl: ->
    @model.get('imageUrl')
