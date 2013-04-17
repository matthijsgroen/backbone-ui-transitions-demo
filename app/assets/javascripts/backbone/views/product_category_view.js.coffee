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

  categoryUrl: ->
    "/categories/#{@model.id}"

  categoryImageUrl: ->
    @model.get 'imageUrl'

  open: (options = {}) ->
    return `when`.resolve(@folderView) if @isOpen()
    @model.loadProducts().then (products) =>
      @_createFolderView(products)
      @parent.activateFolder(this).then =>
        `when`.all([@transitionAddClass('active'), @folderView.open()]).then =>
          @trigger('opened', this) unless options.silent?
          @folderView

  isOpen: ->
    @$el.is('.active')

  close: (options = {})->
    return `when`.resolve() unless @isOpen()
    @folderView.close().then =>
      @transitionRemoveClass('active').then =>
        @_destroyFolderView()
        @trigger('closed', this) unless options.silent?

  toggleFolder: (event) ->
    event.preventDefault()
    if @isOpen()
      @close().then =>
        Backbone.history.navigate ''
    else
      @open().then =>
        Backbone.history.navigate @categoryUrl()
    false

  _createFolderView: (products) ->
    return @folderView if @folderView?
    @folderView = new UIDemo.Views.ProductsView
      collection: products
      category: @model
    @folderView.render()

  _destroyFolderView: ->
    @folderView.remove()
    delete @['folderView']



