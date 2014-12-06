$(document).ready ->
  $(":input.multiUpload[type=\"file\"]").multiUpload
    show_filename_only: true
    name_gen: (el) ->
      el.attr("name").replace "new_attachments", new Date().getTime()
      return
  return