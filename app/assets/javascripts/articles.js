var saveCallbackFunction;//Funzione da chiamare quando il salvataggio è terminato
$(function(){
	$(".article_save_button").click(function(e){
		e.preventDefault();
		saveArticle();
	});
	initializeArticleEditingControls();
	initializeArticleFragmentEditControls();
	initializeArticleViewControls();
  });

function saveArticle(callbackFunction){
	stateful_loading($(".article_save_button"));
	//---------------------------Fragments
	$(fragments).each(function(){
		$(".edit_article .fragments_hidden_fields #fragment_"+this.id+"_data").val(JSON.stringify(this.data));
		$(".edit_article .fragments_hidden_fields #fragment_"+this.id+"_images").val(JSON.stringify(this.images));
	});
	//---------------------------Article
	$(".edit_article .article_title_hidden_field").val($(".title_edit_field").val());
	//---------------------------Pages
	var current_page_id = $(".page_controls").data("currentPageId");
	$("#page_"+current_page_id+"_name_field").val($(".page_name_edit_field").val());
	//Page ordering
	var counter = 0;
	$("ul.pages_list li").each(function(){
		counter++;
		var id = $(this).find(".page_miniature").data("pageId");
		$("#page_"+id+"_number_field").val(counter);
	});
	//Page colors
	$("#page_"+current_page_id+"_background_color_field").val($("#page_background_color_edit_field").val());
	$("#page_"+current_page_id+"_foreground_color_field").val($("#page_foreground_color_edit_field").val());
	$("#page_"+current_page_id+"_third_color_field").val($("#page_third_color_edit_field").val());
	
	$("form.edit_article").submit();

	if(callbackFunction!=undefined) saveCallbackFunction = callbackFunction;
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

function initializeArticleEditingControls(){
	initializeArticleNaming();
	
	$(".switch_page_button,.page_styles_apply_button").click(function(){
		saveArticle();
	});
	$(".article_preview_button").click(function(e){
		e.preventDefault();
		saveArticle(function(){
			window.location = $(".article_preview_button").attr("href");
		});
	});
	
	initializePageListDragging();
	initializePageNaming();
	initializePageStyling();
    
    newArticleValidation(); //Validazione form articolo
}

function initializeArticleNaming(){
	$(".article_title, .article_title_edit_button").unbind();
	$(".title_edit_field").keyup(function(){
		var article_title = $(this).val();
		if(article_title.length==0) article_title = "Untitled article";
		$(".article_title").text(article_title);
	});
	$(".article_title, .article_title_edit_button").mouseover(function(){$(".article_title_edit_button").show();});
	$(".article_title, .article_title_edit_button").mouseout(function(){$(".article_title_edit_button").hide();});
	$(".article_title_edit_button").click(function(e){
		e.preventDefault();
		$(".title_edit_field").toggle();
	});
}

function initializeArticleFragmentEditControls(){
	$(".move_to_page_button, .detach_fragment_button").tooltip({placement:'right'});
	$(".article_edit_fragments_container .fragment_container").mouseover(function(){
		$(".article_fragment_edit_controls").css("display","none");
		$(this).find(".article_fragment_edit_controls").first().show();
	});
}

function initializeArticleViewControls(){
	$(".next_page_link,.previous_page_link").unbind('click');
	$(".next_page_link,.previous_page_link").click(function(){
		$(this).text("Loading...");
	});
}
