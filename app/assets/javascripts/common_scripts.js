//Stateful loading buttons: classi .stateful_loading e attributo data-loading-text
function stateful_loading(){
	var bottone = $(".stateful_loading");
	var text = bottone.attr("data-loading-text");
	bottone.val(text);
	bottone.attr("disabled","disabled");
}

//Funzione che mostra il contenuto passatogli in una finestra modale
function modalWindow(title,content){
	$("#genericModalWindow h3").html(title);
	$("#genericModalWindow .modal-body").html(content);
	$("#genericModalWindow").modal('show');
}

//Popover with partial's controls
function initializeControlsPopovers(){
	$(".fragment_view,.fragment_summary,.user_partial").each(function(){
      $(this).popover({
      placement:'left',
      animation:false,
      trigger: 'manual',
      content: function(){
      	return $(this).find(".tooltip_content").html();
      }
    }).click(function(){
    	
	      $(".fragment_view,.fragment_summary,.user_partial").each(function(){
	        $(this).popover('hide');
	      });
	      $(this).popover('toggle');
	      $(".popover-inner a,.popover-inner input,.popover-inner button").click(function(){
	        $(this).parents(".popover").hide();
	      });
	      
    });
  });
}

$(function(){
	initializeControlsPopovers();
  
  
});
