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

  open: (id) ->
    @closeAll().then =>
      @deactivate()
      @activateView(id)

  deactivate: ->
    @$el.addClass('open-category')

  activate: ->
    @$el.removeClass('open-category')

  closeAll: ->
    view = @itemViews.find (v) -> v.isActive()
    p = view?.deactivate()
    `when(p)`.then =>
      @activate()

  activateView: (modelId) ->
    @activeView = @findViewForModel(modelId)
    @activeView.activate().then (nestedView) =>
      @insertFolder(nestedView, @itemViews.indexOf(@activeView))
      nestedView.open()

  _resize: ->
    return unless @activeView?
    @insertFolder(@activeView.folderView, @itemViews.indexOf(@activeView))

  amountPerRow: ->
    containerWidth = @$('ul.categories').width()
    itemWidth = @$('ul.categories li.category:first').outerWidth(true)
    Math.floor(containerWidth / itemWidth)

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

