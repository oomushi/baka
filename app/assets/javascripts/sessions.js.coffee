# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $('body > header > nav').children("a").each ->
    if $(this).next("ul").length > 0
      $(this).mouseenter ->
        $(this).next("ul").stop(true, true).slideDown()
        true
      $(this).mouseleave ->
        $(this).next("ul").stop(true, true).slideUp()
        true
      $(this).next('ul').mouseenter ->
        $(this).stop(true, true).show()
        true
      $(this).next('ul').mouseleave ->
        $(this).stop(true, true).slideUp()
        true
    true
  $('aside').find('a.exit').click ->
    $('#login').hide 'smooth'
    true
  $('aside').find('a.forgotten').click ->
    $('#subforgotten').show()
    $('#sublogin').hide()
    true
  $('aside').find('a.login2').click ->
    $('#subforgotten').hide()
    $('#sublogin').show()
    true
  $('body > header > nav').find('a.login').click ->
    $('#subforgotten').hide()
    $('#sublogin').show()
    $('#login').show 'smooth'
    $('#username').focus()
    true
  true
