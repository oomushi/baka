$(function() {
  var dropArea = document.getElementById("dropbox");
  var dragover = function(evt) {
    evt.stopPropagation();
    evt.preventDefault();
  };
  var drop = function(evt) {
    evt.stopPropagation();
    evt.preventDefault();
    alert('qui');
  };
  dropArea.addEventListener('dragover', dragover , false);
  dropArea.addEventListener('drop', drop , false);
});
