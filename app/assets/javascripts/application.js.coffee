#= require jquery
#= require jquery_ujs
#= require jquery.isotope
#= require jquery.isotope.centered
#= require jquery.tipsy
#= require underscore
#= require progressarc
#= require_self

Gif =
  load: (url, options) ->
    xhr = new XMLHttpRequest()
    xhr.open "GET", url
    xhr.responseType = 'arraybuffer'
    xhr.overrideMimeType 'text/plain; charset=x-user-defined'

    # Theres no reliable way to determine if the image is loading from a cache,
    # so we'll only start emitting progress events after 100ms
    reallyLoading = false

    xhr.onload = (event) ->
      if xhr.readyState == 4
        if xhr.status == 200
          options.completed()

    xhr.onprogress = (event) ->
      if reallyLoading
        options.progress (event.loaded / event.total) * 100

    xhr.send null

    setTimeout =>
      reallyLoading = true
    , 500

  play: ($gif) ->
    $canvas = $gif.find('canvas')
    $image  = $gif.find('img')
    url     = $image.data 'url'
    loading = false

    $canvas.show()
    $canvas.progressArc
      styles:
        fgColor: "#ffffff",
        bgColor: "transparent",
        strokeWidth: 6
      data:
        start: 0

    unless $image.data('preview')
      $image.data 'preview', $image.attr('src')

    $image.data 'playing', true

    Gif.load url,
      progress: (progress) ->
        $canvas.trigger 'setProgress', [ progress ]

      completed: ->
        if $image.data 'playing'
          $image.attr 'src', url
          $canvas.hide()

  pause: ($gif) ->
    $image = $gif.find('img')
    $image.attr 'src', $image.data('preview')
    $image.data 'playing', false

    $gif.find('canvas').hide()

  find: (element) ->
    jQuery(element).closest('.gif')

jQuery ->
  jQuery('.gif-preview').on
    mouseenter: (event) ->
      Gif.play Gif.find(event.target)
    mouseleave: (event) ->
      Gif.pause Gif.find(event.target)

  $('#gifs').isotope
    itemSelector: '.gif'
    layoutMode: 'masonry'
    onLayout: ->
      jQuery('header').width $('#gifs').width()

  $('a').tipsy
    live: true
    gravity: 'w'
    offset: 25
