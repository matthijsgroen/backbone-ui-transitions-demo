
class UIDemo.Views.ProductDetailView extends UIDemo.Views.TransitionView

  open: ($link) ->
    @_placeInFixed($link)
    $layer = @_injectDimmedLayer()
    imageRotate = @_delay(-> $link.addClass 'animate').then =>
      @transitionAddClass('place-right', $link).then =>
        @transitionAddClass('place-image', $link)

    layerShift = @_delay(
      => @transitionRemoveClass('hidden', $layer)
      1000
    )
    `when`.all [imageRotate, layerShift]

  close: ($link) ->
    $layer = $('body > .product-layer')
    $stubImage = $link.parent().find('img.opened')

    imageRotate = @transitionRemoveClass('place-image', $link).then =>
      @transitionRemoveClass('place-right', $link)
    layerShift = @_delay(
      => @transitionAddClass('hidden', $layer)
      500
    )
    `when`.all([imageRotate, layerShift]).then =>
      $layer.remove()
      $link.removeAttr('style').removeClass('animate')
      $link.find('.product-backface').remove()
      $stubImage.remove()

  _placeInFixed: ($link) ->
    $stubImage = $("<img />").attr
      src: ''
      class: 'invisible opened'
      width: $link.width()
      height: $link.height()

    $link.before $stubImage
    $link.css
      position: 'fixed'
    .position(
      my: 'top right'
      at: 'top right'
      of: $stubImage
    )
    $link.append $('<div />').addClass('product-backface')

  _injectDimmedLayer: ->
    $layer = $('<div />').attr
      class: 'product-layer hidden'
    $('body').append $layer
    $layer

