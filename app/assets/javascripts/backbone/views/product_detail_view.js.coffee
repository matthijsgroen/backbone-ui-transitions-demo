
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
    @_placeInFixed($link)
    $layer = @_injectDimmedLayer()
    imageRotate = @tr.delay(-> $link.addClass 'animate').then =>
      @tr.addClass('place-right', $link).then =>
        @tr.addClass('place-image', $link)

    layerShift = @tr.delay(
      => @tr.removeClass('hidden', $layer).then => @tr.removeClass 'hidden'
      500
    )
    # Load data during transition (blocks url navigate)
    #`when`.all([imageRotate, layerShift, @model.fetchDetails()])

    # Load data during transition and do not block transition
    @model.fetchDetails()
    `when`.all([imageRotate, layerShift])

  close: ($link) ->
    $layer = $('body > .product-layer')
    $stubImage = $link.parent().find('img.opened')

    imageRotate = @tr.removeClass('place-image', $link).then =>
      @tr.removeClass('place-right', $link)
    layerShift = @tr.addClass('hidden').then =>
      @tr.addClass('hidden', $layer)
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

