#= require ./transition_view

class UIDemo.Views.ProductsView extends UIDemo.Views.CollectionView
  tagName: 'li'
  className: 'open-group collapsed'
  itemViewClass: UIDemo.Views.ProductListItemView
  collectionSelector: 'ul.products'

  template: JST['products']

  initialize: ({ @category }) ->
    super
    @on 'productView:open', @openProductFromView, this

  categoryName: ->
    @category.get('name')

  open: ->
    @transitionRemoveClass 'collapsed'

  close: ->
    @closeAll().then =>
      @transitionAddClass 'collapsed'

  openProduct: (productId) ->
    activeView = @findViewForModel(productId)
    activeView.open()

  closeAll: ->
    closed = @itemViews.map (v) -> v.close()
    `when`.all(closed)


