//Stateful loading buttons: classi .stateful_loading e attributo data-loading-text
function stateful_loading(element){
	console.log(element);
	var bottone = element;
	console.log(bottone);
	var text = bottone.attr("data-loading-text");
	bottone.val(text);
	bottone.html(text);
	bottone.attr("disabled","disabled");
}

//Funzione che mostra il contenuto passatogli in una finestra modale
function modalWindow(title,content){
	$("#genericModalWindow h3").html(title);
	$("#genericModalWindow .modal-body").html(content);
	$("#genericModalWindow").modal('show');
	$("*").popover('hide');
}
function closeModal(){
	$("#genericModalWindow").modal('hide');
}

//Popover with partial's controls
function initializeControlsPopovers(){
	$(".fragment_container,.fragment_summary,.user_partial").each(function(){
      $(this).popover({
      placement:'right',
      animation:false,
      trigger: 'manual',
      content: function(){
      	//Nascondo alcuni bottoni in determinate situazioni
      	$(".article_edit_fragments_container .hidden_on_article_editing").css("display","none");
      	
      	return $(this).find(".tooltip_content").html();
      }
    }).click(function(){
    	
	      $(".fragment_container,.fragment_summary,.user_partial").each(function(){
	        $(this).popover('hide');
	      });
	      $(this).popover('toggle');
	      $(".popover-inner a,.popover-inner input,.popover-inner button").click(function(){
	        $(this).parents(".popover").hide();
	      });
	      
    });
  });
}

//Utility for disabling textarea carriage return
function disableTextareaCarriageReturn(selector){
	$(selector).keypress(function(event) {
    if(event.which == '13') {
      return false;
    }
  });
}

$(function(){
	initializeControlsPopovers();
});
