# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
add_bbcode = (output, id) ->
  id = "message_text"  if id is `undefined`
  $("#" + id).replaceSelection output.replace("?", $("#" + id).getSelection().text)
###
function add_bbcode(output,id){
  if(id==undefined) id='message_text';
  $('#'+id).replaceSelection(output.replace('?',$('#'+id).getSelection().text));
}
###