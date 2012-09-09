//Validazione form nuovo articolo
$(function(){
	$(".article_save_button").click(function(e){
		e.preventDefault();
		saveArticle();
	});
    newArticleValidation(); //Validazione form articolo
    initializeArticleFragmentEditControls();
  });

function saveArticle(){
	stateful_loading(); //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	//Occhio che viene applicato a tutti i bottoni presenti sulla pagina, va reso più specifico
	$(fragments).each(function(){
		$(".edit_article .fragments_hidden_fields #fragment_"+this.id+"_data").val(JSON.stringify(this.data));
		$(".edit_article .fragments_hidden_fields #fragment_"+this.id+"_images").val(JSON.stringify(this.images));
	});
	$("form.edit_article").submit();
}

function addFragmentHiddenFields(fragment){
	var hiddenDataField = "<input type='hidden' id='fragment_"+fragment.id+"_data' name='fragments["+fragment.id+"][data]'>"
	var hiddenImagesField = "";
	if(fragment.has_images) hiddenImagesField = "<input type='hidden' id='fragment_"+fragment.id+"_images' name='fragments["+fragment.id+"][images]'>";
	$("form.edit_article .fragments_hidden_fields").append(hiddenDataField+hiddenImagesField);
}

function newArticleValidation(){
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
}

function initializeArticleFragmentEditControls(){
	$(".article_edit_fragments_container .fragment_container").mouseover(function(){
		$(".article_fragment_edit_controls").css("display","none");
		$(this).find(".article_fragment_edit_controls").first().show();
	});
}
