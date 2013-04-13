
class UIDemo.Views.ProductCategoriesView extends Backbone.View
  tagName: 'section'
  className: 'products'

  template: JST['product_categories']

  initialize: ->
    @itemViews = _([])
    @collection.on 'reset', @render, this

  open: (id) ->
    @closeAll().then =>
      @deactivate()
      @activateView(id)

  deactivate: ->
    @$el.addClass('open-category')

  render: ->
    @$el.html @template this
    @collection.each (model) =>
      @addItemView model
    this

  addItemView: (model) ->
    itemView = new UIDemo.Views.ProductCategoryView
      model: model
    itemView.parent = this
    @$('ul.categories').append itemView.render().el
    @itemViews.push itemView

  closeAll: ->
    view = @itemViews.find (v) -> v.isActive()
    p = view?.deactivate()
    `when(p)`

  activateView: (modelId) ->
    modelId = parseInt modelId, 10

    view = @itemViews.find (view) -> view.model.id is modelId
    view.activate().then (nestedView) =>
      @insertFolder(nestedView, @itemViews.indexOf(view))

  insertFolder: (viewElement, index) ->
    # calculate amount possible in row
    containerWidth = @$('ul.categories').width()
    itemWidth = @$('ul.categories li.category:first').outerWidth(true)
    amountPerRow = Math.floor(containerWidth / itemWidth)
    indexInRow = index % amountPerRow

    injectPosition = Math.min(
      (Math.floor(index / amountPerRow) * amountPerRow) + amountPerRow
      @itemViews.size()
    )

    jss 'li.open-group::after', {
      left: "#{(140.0 / 2) - 15 + (140 * indexInRow)}px"
    }
    @$("ul.categories :nth-child(#{injectPosition})").after viewElement.$el

    defer = `when`.defer()
    setTimeout ->
      viewElement.open().then -> defer.resolve()
    defer.promise

