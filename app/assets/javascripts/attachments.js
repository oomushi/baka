/*
$(function() {
  var dropArea = document.getElementById("dropbox");
  var dragover = function(evt) {
    evt.stopPropagation();
    evt.preventDefault();
    evt.dataTransfer.dropEffect = 'copy';
  };
  var drop = function(evt) {
    evt.stopPropagation();
    evt.preventDefault();
    var dt=evt.dataTransfer;
    var files=dt.files;
    for(var i=0;i<files.length;i++){
      var fr=new FileReader();
      fr.onload=function(evt){
        var i=$('<input>').attr('type','hidden')
                          .attr('name','pippo')
                          .val(evt.target.result);
        $('#dropbox').after(i);
      };
      fr.readAsDataURL(files[i]);
    }
  };
  dropArea.addEventListener('dragover', dragover , false);
  dropArea.addEventListener('drop', drop , false);
  new MultiSelector($('#dropbox').first()).addElement($('#file_list').first());
});*/
