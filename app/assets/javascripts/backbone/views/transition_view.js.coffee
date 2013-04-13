
class UIDemo.Views.TransitionView extends Backbone.View

  transitionRemoveClass: (className) ->
    p = @_transitionPromise()
    @_delay(=> @$el.removeClass className).then -> p

  transitionAddClass: (className) ->
    p = @_transitionPromise()
    @_delay(=> @$el.addClass className).then ->
      p

  _transitionPromise: ->
    defer = `when`.defer()
    transitionEvent = @_whichTransitionEvent()
    transitionEndEventHandler = =>
      @el.removeEventListener(
        transitionEvent
        transitionEndEventHandler
        false
      )
      defer.resolve()

    @el.addEventListener(
      transitionEvent
      transitionEndEventHandler
      false
    )
    defer.promise

  _whichTransitionEvent: ->
    el = document.createElement('fakeelement')
    transitions =
      'transition': 'transitionend'
      'OTransition': 'oTransitionEnd'
      'MozTransition': 'transitionend'
      'WebkitTransition': 'webkitTransitionEnd'
    return event for property, event of transitions when el.style[property]?

  _delay: (code) ->
    defer = `when`.defer()
    setTimeout ->
      `when(code())`.then => defer.resolve()
    defer.promise
