
class UIDemo.Views.CollectionView extends Backbone.View
  itemViewClass: Backbone.View
  collectionSelector: 'ul'

  initialize: ->
    @itemViews = _([])
    @listenTo @collection, 'reset', @_reset
    @_reset()

  delegateEvents: ->
    super
    @itemViews.each (v) -> v.delegateEvents()

  render: ->
    $element = $(@template this)
    $container = $element.filter(@collectionSelector)
    $container = $element.find(@collectionSelector) if $container.length is 0
    @itemViews.each (itemView) =>
      $container.append itemView.render().el

    @$el.html $element
    this

  _reset: ->
    @itemViews.invoke 'remove'
    @itemViews = _([])
    @collection.each (model) =>
      @addItemView model
    @render()

  addItemView: (model) ->
    itemView = new @itemViewClass
      model: model
    itemView.parent = this

    itemView.on 'all', @_bubbleEvents, this
    @itemViews.push itemView
    itemView

  findViewForModel: (modelId) ->
    modelId = parseInt modelId, 10
    @itemViews.find (view) -> view.model.id is modelId

  _bubbleEvents: (args...) ->
    @trigger args...

