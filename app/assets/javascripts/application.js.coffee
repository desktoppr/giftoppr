Image =
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

  play: ($image) ->
    $canvas = $image.find('canvas')
    $image  = $image.find('img')
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

    Image.load url,
      progress: (progress) ->
        $canvas.trigger 'setProgress', [ progress ]

      completed: ->
        if $image.data 'playing'
          $image.attr 'src', url
          $canvas.hide()

  pause: ($image) ->
    $image = $image.find('img')
    $image.attr 'src', $image.data('preview')
    $image.data 'playing', false

    $image.find('canvas').hide()

  find: (element) ->
    jQuery(element).closest('.image')

InfiniteScroll =
  scroll: _.throttle ->
    scrollTop = $(window).scrollTop()
    bottom    = $(document).height() - $(window).height()
    buffer    = 1000
    nextLink  = $('.pagination .next a')

    if nextLink.length && scrollTop > (bottom - buffer)
      url = nextLink.attr('href')
      callback = _.once (html) -> InfiniteScroll.refresh html, url
      $.get url, callback
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
  jQuery(document).on 'mouseenter', '.image-preview', (event) ->
      image = Image.find(event.target)
      Image.play image
      Clipboard.set image

  jQuery(document).on 'mouseleave', '.image-preview', (event) ->
      Image.pause Image.find(event.target)

  $('a').tipsy
    live: true
    gravity: 'w'
    offset: 25

  $(window).scroll InfiniteScroll.scroll
  InfiniteScroll.scroll()

  $("img.lazy").lazyload(failure_limit: 15)
  $(window).trigger('scroll')

Clipboard = new class
  constructor: ->
    @value = ''

    $(document).keydown (e) =>
      # Only do this if there's something to be put on the clipboard, and it
      # looks like they're starting a copy shortcut
      if !@value || !(e.ctrlKey || e.metaKey)
        return

      if $(e.target).is('input:visible, textarea:visible')
        return

      # Abort if it looks like they've selected some text (maybe they're trying
      # to copy out a bit of the description or something)
      if window.getSelection?()?.toString()
        return

      if document.selection?.createRange().text
        return

      _.defer =>
        $clipboardContainer = $('#clipboard-container')
        $clipboardContainer.empty().show()
        $('<textarea id="clipboard"></textarea>')
        .val(@value)
        .appendTo($clipboardContainer)
        .focus()
        .select()

    $(document).keyup (e) ->
      if $(e.target).is('#clipboard')
        $('#clipboard-container').empty().hide()

  set: (image) ->
    @value = image.data 'url'
