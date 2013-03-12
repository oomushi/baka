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
  $(".emoticons").emoticonize()
  $(".unanimemo").emoticonize animate: false
  $.each $('section.main article'), ->
    $(this).mousemove((e) ->
      e = e or window.event
      if $(this).height() + $(this).position().top - 20 < e.pageY
        $(this).find("nav").show "slide",
          direction: "down"
      else
        $(this).find("nav").hide "slide",
          direction: "down"
      true
    ).mouseleave (e) ->
      $(this).find("nav").hide "slide",
        direction: "down"
      true
    true
  $("nav > .full_path_dropdown").hover ->
    coor = $(this).offset()
    h = $(this).height() + coor.top - 10
    w = coor.left + (($(this).width() - $("nav > aside").width()) / 2)
    $("nav > aside").animate
      top: h
      left: w
    , 0
    $("nav > aside").show('slide', { direction: "up" })
    $("nav > aside").focus()
    true
  $("nav > aside").mouseleave ->
    $(this).hide('slide', { direction: "up" })
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
