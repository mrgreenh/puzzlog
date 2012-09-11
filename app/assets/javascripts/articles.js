//Validazione form nuovo articolo
$(function(){
	$(".article_save_button").click(function(e){
		e.preventDefault();
		saveArticle();
	});
	$('.title_edit_field').autosize();
	disableTextareaCarriageReturn('.title_edit_field');
    newArticleValidation(); //Validazione form articolo
    initializeArticleFragmentEditControls();
    //saveBeforeLeaving();
  });

function saveArticle(){
	stateful_loading($(".article_save_button"));
	//Fragments
	$(fragments).each(function(){
		$(".edit_article .fragments_hidden_fields #fragment_"+this.id+"_data").val(JSON.stringify(this.data));
		$(".edit_article .fragments_hidden_fields #fragment_"+this.id+"_images").val(JSON.stringify(this.images));
	});
	//Article
	$(".edit_article .article_title_hidden_field").val($(".title_edit_field").val());
	//Pages
	var current_page_id = $(".page_controls").data("currentPageId");
	$("#page_"+current_page_id+"_name_field").val($(".page_name_edit_field").val());
	var counter = 0;
	$("ul.pages_list li").each(function(){
		counter++;
		var id = $(this).find(".page_miniature").data("pageId");
		$("#page_"+id+"_number_field").val(counter);
	});
	
	// $("form.edit_article").submit(function(e) {
		// e.preventDefault();
	    // $.ajax({
	        // type: "POST",
	        // url: $("form.edit_article").attr("action"),
	        // data: $("form.edit_article").serializeArray(),
	        // });
	    // return false;
	// });
	
	$("form.edit_article").submit();
}

//Fa si che tutti i link non remoti salvino la pagina prima di lasciarla
function saveBeforeLeaving(){
	$(window).bind('beforeunload', saveArticle);
}

function addFragmentHiddenFields(fragment){
	var hiddenDataField = "<input type='hidden' id='fragment_"+fragment.id+"_data' class='fragment_"+fragment.id+"_hidden_field' name='fragments["+fragment.id+"][data]'>"
	var hiddenImagesField = "";
	if(fragment.has_images) hiddenImagesField = "<input type='hidden' id='fragment_"+fragment.id+"_images' class='fragment_"+fragment.id+"_hidden_field' name='fragments["+fragment.id+"][images]'>";
	$("form.edit_article .fragments_hidden_fields").append(hiddenDataField+hiddenImagesField);
}

function removeFragmentHiddenFields(fragment_id){
	$(".fragment_"+fragment_id+"_hidden_field").remove();
}

function newArticleValidation(){
	$("#new_article").validate({
      errorClass: "help-block",
      submitHandler: function(form) {
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
