#= require jquery
#= require jquery_ujs
#= require underscore
#= require base64ArrayBuffer
#= require progressarc
#= require_self

Gif =
  load: (url, options) ->
    xhr = new XMLHttpRequest()
    xhr.open "GET", url
    xhr.responseType = 'arraybuffer'
    xhr.overrideMimeType 'text/plain; charset=x-user-defined'

    xhr.onload = (event) ->
      if xhr.readyState == 4
        if xhr.status == 200
          base64Encoded = base64ArrayBuffer(xhr.response)
          options.completed base64Encoded

    xhr.onprogress = (event) ->
      options.progress (event.loaded / event.total) * 100

    xhr.send null

  play: ($gif) ->
    $canvas = $gif.find('canvas')
    $image  = $gif.find('img')
    url     = $image.data 'url'

    $canvas.show()
    $canvas.progressArc
      styles:
        fgColor: "#619fb9",
        bgColor: "#333",
        strokeWidth: 10
      data:
        start: 0

    unless $image.data('preview')
      $image.data 'preview', $image.attr('src')

    Gif.load url,
      progress: (progress) ->
        $canvas.trigger 'setProgress', [ progress ]

      completed: (base64) ->
        $image.attr 'src', ('data:image/gif;base64,' + base64)
        $canvas.hide()

  pause: ($gif) ->
    $image = $gif.find('img')
    $image.attr 'src', $image.data('preview')
    $gif.find('canvas').hide()

  find: (element) ->
    jQuery(element).closest('.gif')

jQuery ->
  jQuery('.gif-inner').on
    mouseenter: (event) ->
      Gif.play Gif.find(event.target)
    mouseleave: (event) ->
      Gif.pause Gif.find(event.target)
