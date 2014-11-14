# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  f = ->
    return if $(this).data("unique") is true and $(this).hasClass "link_disabled"
    h = $($("#" + $(this).data("rif")).html().trim())
    new_id = new Date().getTime()
    regexp = new RegExp($(this).data("rif"), "g")
    $.each h.find("*"), ->
      $(this).filter(":disabled").removeAttr "disabled"
      $(this).attr "id", $(this).attr("id").replace(regexp, new_id) unless $(this).attr("id") is `undefined`
      $(this).attr "name", $(this).attr("name").replace(regexp, new_id) unless $(this).attr("name") is `undefined`
      true
    h.find("a[data-rif]").click f
    wrap = $("<div>").addClass('wrapper').append h
    $(this).closest("fieldset").append wrap
    $(this).closest("fieldset").find("a.remove_subobj").click ->
      $(this).parents('.wrapper').parent().find('a.link_disabled').toggleClass "link_disabled" if $(this).data("unique")
      $(this).parents('.wrapper').remove()
      true
    $(this).toggleClass "link_disabled" if $(this).data("unique") is true and not $(this).hasClass "link_disabled"
    true
  $("a[data-rif]").click f
  $("input:disabled").each ->
    $("label[for=\"" + $(this).attr("id") + "\"]").click ->
      $("#" + $(this).attr("for")).removeAttr "disabled"
      true
    true
  $(".emoticons").emoticonize()
  $(".unanimemo").emoticonize animate: false
  $.each $('body section article'), ->
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
