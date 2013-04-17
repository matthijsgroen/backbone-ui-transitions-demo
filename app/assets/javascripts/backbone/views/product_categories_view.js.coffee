#= require ./collection_view
#= require ./product_category_view

class UIDemo.Views.ProductCategoriesView extends UIDemo.Views.CollectionView
  tagName: 'section'
  className: 'products'
  itemViewClass: UIDemo.Views.ProductCategoryView
  collectionSelector: 'ul.categories'

  template: JST['product_categories']

  initialize: ->
    super
    @on 'closed', @_activateIfAllClosed, this
    $(window).on 'resize', _.bind(@_resize, this)

  open: (modelId) ->
    @activeView = @findViewForModel(modelId)
    @activeView.open()

  deactivate: ->
    @$el.addClass('open-category')

  activate: ->
    @$el.removeClass('open-category')

  closeAll: ->
    closed = @itemViews.map (v) -> v.close(silent: true)
    `when`.all(closed).then =>
      @activate()

  activateFolder: (view) ->
    @closeAll().then =>
      @deactivate()
      @activeView = view
      @_positionFolder view

  _positionFolder: (view) ->
    index = @collection.indexOf(view.model)
    amountPerRow = @_amountPerRow()
    # calculate amount possible in row
    indexInRow = index % amountPerRow

    injectPosition = Math.min(
      (Math.floor(index / amountPerRow) * amountPerRow) + amountPerRow
      @itemViews.size()
    )

    setTimeout ->
      jss 'li.open-group::after', {
        left: "#{(140.0 / 2) - 15 + (140 * indexInRow)}px"
      }

    $(@$("ul.categories li.category").get(injectPosition - 1)).after view.folderView.$el
    view.folderView.delegateEvents()

  _amountPerRow: ->
    containerWidth = @$('ul.categories').width()
    itemWidth = @$('ul.categories li.category:first').outerWidth(true)
    Math.floor(containerWidth / itemWidth)

  _resize: ->
    @_positionFolder(@activeView) if @activeView?

  _activateIfAllClosed: ->
    @activate() if @itemViews.every((v) -> !v.isOpen())

