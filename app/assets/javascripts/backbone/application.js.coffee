
class UIDemo.Application

  constructor: ->
    @initialized = no

  initialize: ->
    return if @initialized
    world = {}

    # Event handlers will populate the world with model and collection instances
    @trigger 'application:setup', world

    # Event handlers will use the world objects to instantiate views and routers
    @trigger 'application:initialize', world

    Backbone.history?.start(pushState: yes) unless Backbone.History.started

    setTimeout(
      ->
        UIDemo.Helpers.Transition::initializeTransitions()
      1000
    )
    @initialized = yes


_.extend UIDemo.Application.prototype, Backbone.Events

UIDemo.app = new UIDemo.Application
