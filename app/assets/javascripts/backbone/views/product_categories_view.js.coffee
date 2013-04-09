
class UIDemo.Views.ProductCategoriesView extends Backbone.View
  tagName: 'section'
  className: 'products'

  template: JST['product_categories']

  initialize: ->
    @itemViews = []
    @collection.on 'reset', @render, this

  open: (id) ->
    # calculate amount possible in row
    containerWidth = @$('ul.categories').width()
    itemWidth = @$('ul.categories li.category:first').outerWidth(true)
    amountPerRow = Math.floor(containerWidth / itemWidth)

    # determine row index and view
    for view, index in @itemViews when view.model.id is id
      indexInRow = index % amountPerRow

      # 'activate' loading
      view.activate()
      # after loading, get nested view
      # inject view at correct position
      # open using animation

    # deactivate list


  render: ->
    @$el.html @template this
    @collection.each (model) =>
      @addItemView model
    this

  addItemView: (model) ->
    itemView = new UIDemo.Views.ProductCategoryView
      model: model
    @$('ul.categories').append itemView.render().el
    @itemViews.push itemView

