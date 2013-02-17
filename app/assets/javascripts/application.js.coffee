#= require jquery
#= require jquery_ujs
#= require underscore
#= require_self

Gif =
  load: ($gif) ->
    @toggle $gif

  pause: ($gif) ->
    @toggle $gif

  toggle: ($gif) ->
    $image = $gif.find('img')
    url    = $image.data 'url'

    $image.data 'url', $image.attr('src')
    $image.attr 'src', url

  find: (element) ->
    jQuery(element).closest('.gif')

jQuery ->
  jQuery('.gif-inner').on
    mouseenter: (event) ->
      Gif.load Gif.find(event.target)
    mouseleave: (event) ->
      Gif.pause Gif.find(event.target)
