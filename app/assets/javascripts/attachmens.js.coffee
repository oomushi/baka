$(document).ready ->
  $(":input.multiUpload[type=\"file\"]").multiUpload
    show_filename_only: true
    remove_img: "/assets/mfu_remove.png"
    name_gen: ->
      d=new Date().getTime()
      d+'_uploaded_data'
