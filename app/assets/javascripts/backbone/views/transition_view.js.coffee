
class UIDemo.Views.TransitionView extends Backbone.View

  transitionRemoveClass: (className, $el = @$el) ->
    p = @_transitionPromise($el)
    @_delay(=> $el.removeClass className).then -> p

  transitionAddClass: (className, $el = @$el) ->
    p = @_transitionPromise($el)
    @_delay(=> $el.addClass className).then -> p

  _transitionPromise: ($el) ->
    return `when`.resolve(this) if $('body').is('.no-transitions')

    defer = `when`.defer()
    transitionEvent = @_whichTransitionEvent()
    transitionEndEventHandler = =>
      $el[0].removeEventListener(
        transitionEvent
        transitionEndEventHandler
        false
      )
      defer.resolve(this)

    $el[0].addEventListener(
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

  _delay: (code, time = 0) ->
    time = 0 if $('body').is('.no-transitions')
    defer = `when`.defer()
    setTimeout(
      -> `when(code())`.then (result) => defer.resolve(result)
      time
    )
    defer.promise
