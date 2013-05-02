
class UIDemo.Views.ProductDetailView extends Backbone.View
  tagName: 'section'
  className: 'product-details hidden'
  template: JST['product_details']

  initialize: ->
    @listenTo @model, 'change:description', @render
    opts =
      lines: 13, # The number of lines to draw
      length: 20, # The length of each line
      width: 10, # The line thickness
      radius: 30, # The radius of the inner circle
      corners: 1, # Corner roundness (0..1)
      rotate: 0, # The rotation offset
      direction: 1, # 1: clockwise, -1: counterclockwise
      color: '#fff', # #rgb or #rrggbb
      speed: 0.7, # Rounds per second
      trail: 21, # Afterglow percentage
      shadow: true, # Whether to render a shadow
      hwaccel: false, # Whether to use hardware acceleration
      className: 'spinner', # The CSS class to assign to the spinner
      zIndex: 2e9, # The z-index (defaults to 2000000000)
      top: 'auto', # Top position relative to parent in px
      left: 'auto' # Left position relative to parent in px
    @spinner = new Spinner(opts).spin()
    @tr = new UIDemo.Helpers.Transition(@$el)

  render: ->
    @$el.html @template this
    if @$('.description').text() is ''
      @$('.description').append @spinner.el
    else
      @spinner.stop()
    this

  productName: ->
    @model.get('name')

  productDescription: ->
    markdownDescription = @model.get('description')
    return '' unless markdownDescription
    markdown.toHTML markdownDescription

  open: ($link) ->
    # Load data during transition (blocks url navigate)
    #`when`.all([imageRotate, layerShift, @model.fetchDetails()])
    # Load data during transition and do not block transition
    @model.fetchDetails()
    `when`.all([@_imageRotateOpenAnimation($link), @_dimmedLayerOpenAnimation()]).then =>
      @tr.removeClass 'hidden'

  close: ($link) ->
    `when`.all([@_imageRotateCloseAnimation($link), @_dimmedLayerCloseAnimation()])

  _imageRotateOpenAnimation: ($link) ->
    prefetchImage = `when`.defer()
    detailImage = new Image
    detailImage.onload = ->
      console.log 'image prefetched'
      prefetchImage.resolve(detailImage.src)
    detailImage.src = @model.get('detailImageUrl')

    @_placeInFixed($link)
    @tr.delay(-> $link.addClass 'animate').then =>
      `when`.all([@tr.addClass('place-right', $link), prefetchImage.promise]).then (results) =>
        $link.find('img').attr('src', results[1])
        @tr.addClass('place-image', $link)

  _imageRotateCloseAnimation: ($link) ->
    @tr.removeClass('place-image', $link).then =>
      @tr.removeClass('place-right', $link).then =>
        @_removeFixedFrom($link)

  _dimmedLayerOpenAnimation: ->
    $layer = $('<div />').attr
      class: 'product-layer hidden'
    $('body').append $layer

    @tr.delay(
      => @tr.removeClass('hidden', $layer)
      500
    )

  _dimmedLayerCloseAnimation: ->
    $layer = $('body > .product-layer')
    @tr.addClass('hidden').then =>
      @tr.addClass('hidden', $layer).then =>
        $layer.remove()

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

  _removeFixedFrom: ($link) ->
    $stubImage = $link.parent().find('img.opened')
    $link.removeAttr('style').removeClass('animate')
    $link.find('.product-backface').remove()
    $stubImage.remove()


