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
		var page_name = $(this).val();
		if(page_name.length==0) page_name = "Unnamed Page";
		$(".page_miniature.current_page p").text(page_name);
	});
	$('.page_name_edit_field').autosize(); 
}
