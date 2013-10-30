function initializePageListDragging(){
	$("ul.pages_list").dragsort("destroy");
	$("ul.pages_list").dragsort({ dragSelector: "li img", dragBetween: true, scrollContainer: "ul.pages_list", placeHolderTemplate:"<li></li>", dragEnd: function() {
			saveArticle();
		}
	}); 
}

function initializePageNaming(){
	$(".page_miniature p").dotdotdot();
	$(".page_name_edit_field").keyup(function(){
		var page_name = $(this).val();
		if(page_name.length==0) page_name = "Unnamed Page";
		$(".page_miniature.current_page p, .page_controls h2").text(page_name);
	}); 
	
	//Page name edit button
	$(".page_name, .page_name_edit_button").unbind();
	$(".page_name, .page_name_edit_button").mouseover(function(){$(".page_name_edit_button").show();});
	$(".page_name, .page_name_edit_button").mouseout(function(){$(".page_name_edit_button").hide();});
	$(".page_name_edit_button").click(function(e){
		e.preventDefault();
		$(".page_name_edit_field").toggle();
	});
}
