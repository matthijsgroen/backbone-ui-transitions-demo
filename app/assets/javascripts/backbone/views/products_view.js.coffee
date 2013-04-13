#= require ./transition_view

class UIDemo.Views.ProductsView extends UIDemo.Views.TransitionView
  tagName: 'li'
  className: 'open-group collapsed'
  template: JST['products']

  render: ->
    @$el.html @template this
    @$el.attr('data-position', (-140 / 2) - 15 + (140 * 4))
    this

  open: ->
    @transitionRemoveClass 'collapsed'

  close: ->
    @transitionAddClass 'collapsed'

