//Validazione form nuovo articolo

$(function(){
    $("#new_article").validate({
      errorClass: "help-block",
      submitHandler: function(form) {
        stateful_loading();
        form.submit();
        },
      highlight: function(element, errorClass, validClass) {
           $(element).parent('fieldset').addClass('error');
        },
        unhighlight: function(element, errorClass, validClass) {
          $(element).parent('fieldset').removeClass('error');
        }
    });
  });