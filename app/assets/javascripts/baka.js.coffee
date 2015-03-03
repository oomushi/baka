$(document).ready ->
  $(".messages").fadeOut 2000  if $(".messages").length > 0
  $('img[src$=".svg"],img[src$=".svgz"]').svgInject();
  return
