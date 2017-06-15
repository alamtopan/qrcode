function previewFile(input, imageHeader) {
  var preview = imageHeader[0];
  var file    = input.files[0];
  var reader  = new FileReader();

  reader.onloadend = function () {
    preview.src = reader.result;
  }

  if (file) {
    reader.readAsDataURL(file);
  } else {
    preview.src = "";
  }
}

$(document).ready(function(){
  $('.avatar-input').on('change', function(index){
    if($(this).length){
      previewFile(this, $('.avatar'));
    }
  });
});