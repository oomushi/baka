# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $("#group_user_ids").asmSelect removeLabel: 'remove'

  $("#group_users").autocomplete
    delay: 1000
    source: (request, response) ->
      params = term: request.term
      $.get "/users/complete", params, response

    select: (event,ui) ->
      if $("#group_user_ids").val().indexOf(''+ui.item.id) < 0
        option = $("<option></option>").text(ui.item.username).attr "selected", true
        option.val ui.item.id
        $("#group_user_ids").append(option).change()
      $(this).val ''
      false

