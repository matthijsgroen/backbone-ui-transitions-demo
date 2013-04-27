
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
      =>
        if @transitionEventName()?
          $('body').removeClass('no-transitions').addClass('transitions')
      1000
    )
    @initialized = yes

  transitionEventName: ->
    el = document.createElement('fakeelement')
    transitions =
      'transition': 'transitionend'
      'OTransition': 'oTransitionEnd'
      'MozTransition': 'transitionend'
      'WebkitTransition': 'webkitTransitionEnd'
    return event for property, event of transitions when el.style[property]?

_.extend UIDemo.Application.prototype, Backbone.Events

UIDemo.app = new UIDemo.Application
