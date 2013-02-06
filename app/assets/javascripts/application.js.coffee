#= require jquery
#= require jquery_ujs
#= require infinity
#= require underscore
#= require backbone
#= require handlebars
#= require_self

infinity.config.PAGE_TO_SCREEN_RATIO = 1
infinity.config.SCROLL_THROTTLE = 200

jQuery =>
  $el = $('#gifs')
  listView = new infinity.ListView($el)

  #i = 0
  #$('.gif').each (i, x) =>
  # listView.append jQuery(x.outerHTML)

  $(window).scroll ->
    console.log 'asdf'
