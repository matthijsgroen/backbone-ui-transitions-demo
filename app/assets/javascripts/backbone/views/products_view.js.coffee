#= require ./transition_view

class UIDemo.Views.ProductsView extends UIDemo.Views.CollectionView
  tagName: 'li'
  className: 'open-group collapsed'
  itemViewClass: UIDemo.Views.ProductView
  collectionSelector: 'ul.products'

  template: JST['products']

  initialize: ({ @category }) ->
    super

  categoryName: ->
    @category.get('name')

  open: ->
    @transitionRemoveClass 'collapsed'

  close: ->
    @transitionAddClass 'collapsed'

