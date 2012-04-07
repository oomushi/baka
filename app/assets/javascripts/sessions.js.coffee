# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  nav=$('body > header > nav')
  nav.children("a").each ->
    if $(this).next("ul").length > 0
      $(this).mouseenter ->
        $(this).next("ul").stop(true, true).slideDown()
      $(this).mouseleave ->
        $(this).next("ul").stop(true, true).slideUp()
      $(this).next('ul').mouseenter ->
        $(this).stop(true, true).show()
      $(this).next('ul').mouseleave ->
        $(this).stop(true, true).slideUp()
@login = ->
  $('#login').show 'smooth'
  $('#username').focus
