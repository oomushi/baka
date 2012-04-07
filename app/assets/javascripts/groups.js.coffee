# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $("#group_user_ids").asmSelect removeLabel: 'remove'
  $("#group_users").autocomplete
    source: (request, response) ->
      params =
        term: request.term

        $.get "/users/complete", params, (data) ->
          if data.length > 0
            option = $("<option></option>").text(data).attr "selected", true
            $("#group_user_ids").append(option).change()
            false

    delay: 1000

