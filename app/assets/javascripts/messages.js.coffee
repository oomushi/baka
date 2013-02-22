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
@unique_add = (link,association,content) ->
  unless $(link).hasClass "link_disabled"
    $(link).toggleClass "link_disabled"
    add_fields link,association,content
@unique_remove = (link) ->
  l=$(link).parent().parent().find("a.link_disabled")[0]
  $(l).toggleClass "link_disabled"
  remove_fields link
$(document).ready ->
  $("input:disabled").each ->
    $("label[for=\"" + $(this).attr("id") + "\"]").click ->
      $("#" + $(this).attr("for")).removeAttr "disabled"
      true
    true
  $("nav > .full_path_dropdown").click ->
    coor = $("nav > .full_path_dropdown").offset()
    h = $("nav > .full_path_dropdown").height() + coor.top - 10
    w = coor.left + (($("nav > .full_path_dropdown").width() - $("aside.full_path_dropdown").width()) / 2)
    $("aside.full_path_dropdown").animate
      top: h
      left: w
    , 0
    $("aside.full_path_dropdown").show('slow')
    $("aside.full_path_dropdown").focus()
    true
  $("aside.full_path_dropdown").mouseleave ->
    $("aside.full_path_dropdown").hide('slow')
    true
  $("tr.link").click( ->
    location.href=$(this).data("url")
    true
  ).hover( ->
    $(this).children().addClass "hover"
    true
  , ->
    $(this).children().removeClass "hover"
    true
  )
  true
