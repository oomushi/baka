$(document).ready ->
  $(":input.multiUpload[type=\"file\"]").multiUpload
    show_filename_only: true
    remove_img: "/assets/mfu_remove.png"
    name_gen: (el) ->
      el.attr("name").replace "new_attachments", new Date().getTime()