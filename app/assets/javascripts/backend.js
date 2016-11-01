//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require app
//= require cocoon
//= require jquery_ui

$(document).ready(function(){
  $('.datepicker').datepicker({
    dateFormat: "yy-mm-dd"
  });

  $(".check_all_box input").click(function(){
    $('input:checkbox').not(this).prop('checked', this.checked);
  });
  
  $(".avatar-form").on('click', '.btn-choice',function() {
    $(this).closest('.avatar-form').find('input[type="file"]').click();
  });

  $(".avatar-form").find("input[type='file']").on("change", function () {
    var reader = new FileReader();
    reader.onload = function (e) {
      $(".avatar-form").find("img")[0].src = e.target.result;
    };
    reader.readAsDataURL($(this)[0].files[0]);
  });

  $(".video_kind_movie").each(function(){
    $(this).click(function(){
      if($(this).val() == 'Movies'){
        $('.section-video').hide();
      }else{
        $('.section-video').show();
      }
    });

    if($(this).val() != '' && $(this).val() != 'undefined'){
      type = $(this).filter(':checked').val();

      if(type == 'Series'){
        $('.section-video').show();
      }else{
        $('.section-video').hide();
      }
    }
  });
});