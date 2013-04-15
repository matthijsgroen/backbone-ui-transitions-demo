
class UIDemo.Views.ProductListItemView extends Backbone.View
  tagName: 'li'
  className: 'product'
  template: JST['product_list_item']

  events:
    'click a': 'openProduct'

  render: ->
    @$el.html @template this
    this

  url: ->
    "#categories/#{@model.collection.categoryId}/products/#{@model.id}"

  imageUrl: ->
    @model.get('image_url')

  open: ->
    # ensure existence of detailView
    @detailView ?= new UIDemo.Views.ProductDetailView
       model: @model
    $('body').append @detailView.el

    # submit the 'a' instead of the img.
    # this way we rotate the entire link and can provide a custom backface to the image.
    # see: http://desandro.github.io/3dtransforms/docs/card-flip.html
    @detailView.open(@$('a')).then =>
      @detailView
    #   @model.loadDetails().then =>
    #     @detailView

  close: ->
    @detailView.close(@$('a')).then =>
      @detailView.remove()

  openProduct: (event) ->
    event.preventDefault()
    if @$('img:first').is('.opened')
      @close().then =>
        Backbone.history.navigate "#categories/#{@model.collection.categoryId}"
    else
      @open().then =>
        Backbone.history.navigate @url()
    false
