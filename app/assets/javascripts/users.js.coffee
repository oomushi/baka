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
          $("#user_username").css('background-color','#fdd')
          alert "Someone already has that username. Try another?"
        else
          $("#user_username").css('background-color','#dfd')

    delay: 1000

