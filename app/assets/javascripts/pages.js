$(function(){
	initializePageListDragging();
	initializePageNaming();
	disableTextareaCarriageReturn('.page_name_edit_field');
});

function initializePageListDragging(){
	$("ul.pages_list").dragsort({ dragSelector: "li img", dragBetween: true, scrollContainer: "ul.pages_list", dragEnd: function() {
			saveArticle();
		}
	}); 
}

function initializePageNaming(){
	$(".page_miniature p").dotdotdot();
	$(".page_name_edit_field").keyup(function(){
		$(".page_miniature.current_page p").text($(this).val());
	});
	$('.page_name_edit_field').autosize(); 
}
