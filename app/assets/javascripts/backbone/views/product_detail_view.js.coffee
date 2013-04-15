
class UIDemo.Views.ProductDetailView extends UIDemo.Views.TransitionView

  open: ($image) ->
    @_placeInFixed($image)
    $layer = @_injectDimmedLayer()
    imageRotate = @_delay(-> $image.addClass 'animate').then =>
      @transitionAddClass('place-right', $image).then =>
        @transitionAddClass('place-image', $image)

    layerShift = @_delay(
      => @transitionRemoveClass('hidden', $layer)
      1000
    )
    `when`.all [imageRotate, layerShift]

  close: ($image) ->
    $layer = $('body > .product-layer')
    $image.addClass('reverse')

    imageRotate = @transitionRemoveClass('place-image', $image).then =>
      @transitionRemoveClass('place-right', $image)
    layerShift = @_delay(
      => @transitionAddClass('hidden', $layer)
      500
    )
    `when`.all([imageRotate, layerShift]).then =>
      $layer.remove()
      $image.removeAttr('style').removeClass('animate')
      $image.parent().find('img.opened').remove()

  _placeInFixed: ($image) ->
    $stubImage = $("<img />").attr
      src: ''
      class: 'invisible opened'
      width: $image.width()
      height: $image.height()

    $image.before $stubImage
    $image.css
      position: 'fixed'
    .position(
      my: 'top right'
      at: 'top right'
      of: $stubImage
    )

  _injectDimmedLayer: ->
    $layer = $('<div />').attr
      class: 'product-layer hidden'
    $('body').append $layer
    $layer

