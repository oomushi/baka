$(document).ready ->
  $.each $("[data-tag]"), (index, value) ->
    $(value).click (e) ->
      i = $("#message_text")[0].selectionStart
      e = $("#message_text")[0].selectionEnd
      text = $("#message_text").val()
      mid = $(this).data("tag").replace(/^(.+)\?(.+?)$/, '$1'+text.substring(i, e)+'$2')
      $("#message_text").val text.substring(0, i) + mid + text.substring(e, text.length)
      e.stopPropagation()
      true
    true
  $("html").click ->
    $('.hiddenAside').hide()
    true
  $(".emoji").click (e) ->
    coord = $(this).offset()
    $('#emoji').show()
    posy = coord.top + 16
    posx = coord.left + 16
    $("#emoji").animate
      top: posy
      left: posx
    e.stopPropagation()
    true
  $(".hiddenAside").click (e) ->
    e.stopPropagation()
    false
  true
