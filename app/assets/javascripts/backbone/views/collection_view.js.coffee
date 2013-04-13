#= require ./transition_view

class UIDemo.Views.CollectionView extends UIDemo.Views.TransitionView
  itemViewClass: Backbone.View
  collectionSelector: 'ul'

  initialize: ->
    @itemViews = _([])
    @collection.on 'reset', @render, this

  render: ->
    @$el.html @template this
    @collection.each (model) =>
      @addItemView model
    this

  addItemView: (model) ->
    itemView = new @itemViewClass
      model: model
    itemView.parent = this
    @$(@collectionSelector).append itemView.render().el
    @itemViews.push itemView

  findViewForModel: (modelId) ->
    modelId = parseInt modelId, 10
    @itemViews.find (view) -> view.model.id is modelId

