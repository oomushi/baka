# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $("#user_username").autocomplete
    source: (request, response) ->
      params =
        exac: true
        term: request.term

      $.get "/users/complete", params, (data) ->
        if data.length > 0
          alert "username già preso"
        else
          alert "ok"

    delay: 1000

