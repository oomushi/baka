# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@remove_fields = (link) ->
  $(link).prev("input[type=hidden]").val "1"
  $(link).closest(".field").hide()
@unique_remove = (link) ->
  l=$(link).parent().parent().find("a.link_disabled")[0]
  $(l).toggleClass "link_disabled"
  remove_fields link
$(document).ready ->
  f = ->
    return if $(this).data("unique") is true and $(this).hasClass "link_disabled"
    h = $("#" + $(this).data("rif")).children().clone()
    new_id = new Date().getTime()
    regexp = new RegExp($(this).data("rif"), "g")
    $.each h.find("*"), ->
      $(this).filter(":disabled").removeAttr "disabled"
      $(this).attr "id", $(this).attr("id").replace(regexp, new_id) unless $(this).attr("id") is `undefined`
      true
    h.find("a[data-rif]").click f
    # parents è troppo generico ci vuole solo il primo antenato buono
    $(this).parents("fieldset").append h
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
