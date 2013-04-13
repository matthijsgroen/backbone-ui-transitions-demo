#= require ./transition_view

class UIDemo.Views.ProductCategoryView extends UIDemo.Views.TransitionView
  tagName: 'li'
  className: 'category'

  template: JST['product_category']

  initialize: ->
    @model.on 'products:loading', @markLoading, this
    @model.on 'products:loaded', @clearLoading, this
    @folderView = new UIDemo.Views.ProductsView
      collection: @model.products

  render: ->
    @$el.html @template this
    this

  activate: ->
    @transitionAddClass('active').then =>
      @folderView.render()

  markLoading: ->
    @$el.addClass('loading')

  clearLoading: ->
    @$el.removeClass('loading')

  isActive: ->
    @$el.is('.active')

  deactivate: ->
    @$el.removeClass('loading')
    @folderView.close().then =>
      @transitionRemoveClass('active').then =>
        @folderView.remove()

  categoryUrl: ->
    "#categories/#{@model.id}"

  categoryImageUrl: ->
    @model.get 'image_url'

  open: ->
    folderView = @parent.createFolderView(this, collection: @model.products)
    folderView


