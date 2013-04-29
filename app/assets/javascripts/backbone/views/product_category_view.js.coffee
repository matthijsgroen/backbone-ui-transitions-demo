
class UIDemo.Views.ProductCategoryView extends Backbone.View
  tagName: 'li'
  className: 'category'

  template: JST['product_category']
  events:
    'click a': 'toggleFolder'

  initialize: ->
    @listenTo @model, 'products:loading', @markLoading
    @listenTo @model, 'products:loaded', @clearLoading

    @tr = new UIDemo.Helpers.Transition(@$el)

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
        @$el.addClass('active')
        `when`.all([@tr.addClass('open'), @folderView.open()]).then =>
          @trigger('opened', this) unless options.silent?
          @folderView

  isOpen: ->
    @$el.is('.open')

  close: (options = {})->
    return `when`.resolve() unless @isOpen()
    @folderView.close().then =>
      @_destroyFolderView()
      @tr.removeClass('open').then =>
        @trigger('closed', this) unless options.silent?

  toggleFolder: (event) ->
    event.preventDefault()
    if @isOpen()
      @close().then =>
        Backbone.history.navigate ''
    else
      @open().then(
        =>
          Backbone.history.navigate @categoryUrl()
        (error) =>
          console.log error, error.message
      )

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

