
class UIDemo.Views.ProductsView extends UIDemo.Views.CollectionView
  tagName: 'li'
  className: 'open-group collapsed'
  itemViewClass: UIDemo.Views.ProductListItemView
  collectionSelector: 'ul.products'

  template: JST['products']

  initialize: ({ @category }) ->
    super
    @on 'productView:open', @openProductFromView, this
    @tr = new UIDemo.Helpers.Transition(@$el)

  categoryName: ->
    @category.get('name')

  open: ->
    @tr.removeClass 'collapsed'

  close: ->
    @closeAll().then =>
      @tr.addClass 'collapsed'

  openProduct: (productId) ->
    activeView = @findViewForModel(productId)
    activeView.open()

  closeAll: ->
    closed = @itemViews.map (v) -> v.close()
    `when`.all(closed)

