#= require jquery
#= require jquery_ujs
#= require underscore
#= require_self

Gif =
  load: (url, options) ->
    xhr = new XMLHttpRequest()
    xhr.open "GET", url

    xhr.onload = (event) ->
      options.completed()

    xhr.onprogress = (event) ->
      percentage = (event.loaded / event.total) * 100

    xhr.send()

  play: ($gif) ->
    @toggle $gif

  pause: ($gif) ->
    @toggle $gif

  toggle: ($gif) ->
    $image = $gif.find('img')
    url    = $image.data 'url'

    Gif.load url,
      progress: ->
        console.log arguments
      completed: ->
        $image.data 'url', $image.attr('src')
        $image.attr 'src', url

  find: (element) ->
    jQuery(element).closest('.gif')

jQuery ->
  jQuery('.gif-inner').on
    mouseenter: (event) ->
      Gif.play Gif.find(event.target)
    mouseleave: (event) ->
      Gif.pause Gif.find(event.target)
