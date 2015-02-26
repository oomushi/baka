# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
# TODO capire che serva il seguente metodo
  $('body > header > nav').children("a").each ->
    if $(this).next("ul").length > 0
      $(this).mouseenter ->
        $(this).next("ul").stop(true, true).slideDown()
        return
      $(this).mouseleave ->
        $(this).next("ul").stop(true, true).slideUp()
        return
      $(this).next('ul').mouseenter ->
        $(this).stop(true, true).show()
        return
      $(this).next('ul').mouseleave ->
        $(this).stop(true, true).slideUp()
        return
      return
  $('aside').find('a.exit').click ->
    $('#login').hide 'smooth'
    return
  $('body > header > nav').find('a.login').click ->
    $('#login').show 'smooth'
    return
  return
