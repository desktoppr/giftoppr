#= require jquery
#= require jquery_ujs
#= require infinity
#= require_self

jQuery =>
  $el = $('#gifs')
  listView = new infinity.ListView($el)

  i = 0
  $('.gif').each (i, x) =>
    listView.append jQuery(x.outerHTML)
