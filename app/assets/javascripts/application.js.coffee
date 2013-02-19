#= require jquery
#= require jquery_ujs
#= require jquery.tipsy
#= require jquery.lazyload
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

InfiniteScroll =
  scroll: _.throttle ->
    scrollTop = $(window).scrollTop()
    bottom    = $(document).height() - $(window).height()
    buffer    = 1000
    nextLink  = $('.pagination .next a')

    if nextLink.length && scrollTop > (bottom - buffer)
      url = nextLink.attr('href')
      $.get url, (html) ->
        InfiniteScroll.refresh html, url
  , 250

  refresh: (html, url) ->
    history.replaceState null, null, url

    context = jQuery jQuery.parseHTML(html)

    # Don't lazy load these images
    context.find('img.lazy').each (idx, el) ->
      el = jQuery(el)
      el.attr 'src', el.data('original')

    # Update groups
    jQuery('#group-0').append context.find('#group-0').html()
    jQuery('#group-1').append context.find('#group-1').html()
    jQuery('#group-2').append context.find('#group-2').html()

    # Update pagination
    jQuery('.pagination').replaceWith context.find('.pagination')

    # Hide pagination
    $('.pagination').hide()

jQuery ->
  jQuery(document).on 'mouseenter', '.gif-preview', (event) ->
      Gif.play Gif.find(event.target)

  jQuery(document).on 'mouseleave', '.gif-preview', (event) ->
      Gif.pause Gif.find(event.target)

  $('a').tipsy
    live: true
    gravity: 'w'
    offset: 25

  $(window).scroll InfiniteScroll.scroll
  InfiniteScroll.scroll()

  $("img.lazy").lazyload(effect: "fadeIn", failure_limit: 15)
  $(window).trigger('scroll')
