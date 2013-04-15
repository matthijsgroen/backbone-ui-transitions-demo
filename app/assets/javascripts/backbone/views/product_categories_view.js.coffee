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
    $(window).on 'resize', _.bind(@_resize, this)

  open: (modelId) ->
    @activeView = @findViewForModel(modelId)
    @activeView.open()

  deactivate: ->
    @$el.addClass('open-category')

  activate: ->
    @$el.removeClass('open-category')

  closeAll: ->
    deactivations = @itemViews.map (v) -> v.deactivate()
    `when`.all(deactivations).then =>
      @activate()

  _resize: ->
    return unless @activeView?
    @insertFolder(@activeView.folderView, @itemViews.indexOf(@activeView))

  amountPerRow: ->
    containerWidth = @$('ul.categories').width()
    itemWidth = @$('ul.categories li.category:first').outerWidth(true)
    Math.floor(containerWidth / itemWidth)

  openFolder: (folderView, view) ->
    @closeAll().then =>
      @deactivate()
      @activeView = view
      @insertFolder folderView, @collection.indexOf(view.model)

  insertFolder: (viewElement, index) ->
    amountPerRow = @amountPerRow()
    # calculate amount possible in row
    indexInRow = index % amountPerRow

    injectPosition = Math.min(
      (Math.floor(index / amountPerRow) * amountPerRow) + amountPerRow
      @itemViews.size()
    )

    jss 'li.open-group::after', {
      left: "#{(140.0 / 2) - 15 + (140 * indexInRow)}px"
    }
    $(@$("ul.categories li.category").get(injectPosition - 1)).after viewElement.$el
    viewElement.delegateEvents()

