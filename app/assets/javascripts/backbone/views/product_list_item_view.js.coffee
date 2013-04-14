
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
    console.log "opening Product: #{@model.get('name')}"
    # ensure existence of detailView
    # @detailView ?= new UIDemo.View.ProductDetailView
    #   model: @model
    #
    # $('body').append @detailView
    # @detailView.open @$('img').then =>
    #   @model.loadDetails().then =>
    #     @detailView
    `when`.resolve()

  openProduct: (event) ->
    event.preventDefault()
    @open().then =>
      Backbone.history.navigate @url()
    false
