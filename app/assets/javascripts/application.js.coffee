#= require jquery
#= require jquery_ujs
#= require underscore
#= require_self

Gif =
  load: ($gif) ->
    url = $gif.data 'gif-url'
    container = $gif.find('.gif-container')

    container.html """<img src="#{url}" width="#{container.width()}" height="#{container.height()}" />"""

  pause: ($gif) ->
    $gif.find('.gif-container').html ""

  find: (element) ->
    jQuery(element).closest('.gif')

jQuery ->
  jQuery('.gif-inner').on
    mouseenter: (event) ->
      Gif.load Gif.find(event.target)
    mouseleave: (event) ->
      Gif.pause Gif.find(event.target)
