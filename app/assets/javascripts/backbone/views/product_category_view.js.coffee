#= require ./transition_view

class UIDemo.Views.ProductCategoryView extends UIDemo.Views.TransitionView
  tagName: 'li'
  className: 'category'

  template: JST['product_category']
  events:
    'click a': 'toggleFolder'

  initialize: ->
    @model.on 'products:loading', @markLoading, this
    @model.on 'products:loaded', @clearLoading, this

  render: ->
    @$el.html @template this
    this

  markLoading: ->
    @$el.addClass('loading')

  clearLoading: ->
    @$el.removeClass('loading')

  deactivate: ->
    return `when`.resolve() unless @$el.is('.active')
    @folderView.close().then =>
      @transitionRemoveClass('active').then =>
        @folderView.remove()

  categoryUrl: ->
    "#categories/#{@model.id}"

  categoryImageUrl: ->
    @model.get 'image_url'

  open: ->
    @model.loadProducts().then (products) =>
      @folderView ?= new UIDemo.Views.ProductsView
        collection: products
        category: @model
      @parent.openFolder(@folderView.render(), this).then =>
        `when`.all([@transitionAddClass('active'), @folderView.open()]).then =>
          @folderView

  toggleFolder: (event) ->
    event.preventDefault()
    if @$el.is('.active')
      @parent.closeAll().then =>
        Backbone.history.navigate ''
    else
      @open().then =>
        Backbone.history.navigate @categoryUrl()
    false

