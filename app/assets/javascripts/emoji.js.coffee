$(document).ready ->
  $.each $("[data-tag]"), (index, value) ->
    $(this).click (ev) ->
      i = $("#message_text")[0].selectionStart
      e = $("#message_text")[0].selectionEnd
      text = $("#message_text").val()
      mid = $(this).data("tag").replace(/^(.+)\?(.+?)$/, '$1'+text.substring(i, e)+'$2')
      $("#message_text").val text.substring(0, i) + mid + text.substring(e, text.length)
      ev.stopPropagation()
      false
    true
  $("html").click ->
    $('.hiddenAside').hide()
    true
  $(".hiddenAside").click (e) ->
    e.stopPropagation()
    false
  true
