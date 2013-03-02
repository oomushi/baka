# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $.each $("[data-tag]"), (index, value) ->
    $(value).click ->
      i = $("#message_text")[0].selectionStart
      e = $("#message_text")[0].selectionEnd
      text = $("#message_text").val()
      mid = $(this).data("tag").replace(/^(.+)\?(.+?)$/, '$1'+text.substring(i, e)+'$2')
      $("#message_text").val text.substring(0, i) + mid + text.substring(e, text.length)
      true
    true
  true
