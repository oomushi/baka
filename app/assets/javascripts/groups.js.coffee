# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $("#group_users").autocomplete
    delay: 1000
    source: (request, response) ->
      params = term: request.term
      $.get "/users/complete", params, response

    select: (event,ui) ->
      if $("input[name='group[user_ids][]']").val().indexOf(''+ui.item.id) < 0
        option=$('<input>').attr('type','checkbox').attr('name','group[user_ids][]').attr('checked',true).val ui.item.id
        $("#habtm").append option
        $("#habtm").append ui.item.username
        $("#habtm").append $("<br>")
      $(this).val ''
      false

