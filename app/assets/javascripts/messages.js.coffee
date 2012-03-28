# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@remove_fields = (link) ->
  $(link).prev("input[type=hidden]").val "1"
  $(link).closest(".field").hide()
@add_fields = (link, association, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp("new_" + association, "g")
  $(link).parent().parent().append content.replace(regexp, new_id)
@func=null
@unique_add = (link) ->
  @func = link.onclick
  link.onclick = ->
  $(link).toggleClass "link_disabled"
@unique_remove = (link) ->
  l =  $(link).parent().parent().find("a.link_disabled")[0]
  l.onclick = @func
  $(l).toggleClass "link_disabled"
