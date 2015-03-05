# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $(".markItUp").markItUp(mySettings)
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
  $.each $('body section article'), ->
    $(this).mousemove((e) ->
      e = e or window.event
      if $(this).height() + $(this).position().top - 20 < e.pageY
        $(this).find("nav:hidden").show()
      else
        $(this).find("nav:visible").hide "slide",
          direction: "down"
      return
    ).mouseleave (e) ->
      $(this).find("nav").hide "slide",
        direction: "down"
      return
    return
  $("nav > .full_path_dropdown").hover ->
    $("#tripledot,#tdextended").toggle "slide",
      direction: "down"
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
