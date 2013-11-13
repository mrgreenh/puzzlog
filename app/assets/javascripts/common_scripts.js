//Stateful loading buttons: classi .stateful_loading e attributo data-loading-text
function stateful_loading(element){
	var bottone = element;
	var text = bottone.attr("data-loading-text");
	bottone.val(text);
	bottone.html(text);
	bottone.attr("disabled","disabled");
}

//Flash messages slide up after some seconds
function flashMessages(){
	timeoutID = window.setTimeout(function(){
		$("#flash_messages_container").slideUp();
	}, 5000);
}

//Funzione che mostra il contenuto passatogli in una finestra modale
function modalWindow(title,content){
	$("#genericModalWindow h3").html(title);
	$("#genericModalWindow .modal-body").html(content);
	$("#genericModalWindow").modal('show');
	$("[data-original-title]").popover('hide');
}
function closeModal(){
	$("#genericModalWindow").modal('hide');
}

//Popover with partial's controls
function initializeControlsPopovers(){
	$(".fragment_container .controls_popover_toggler,.fragment_summary .controls_popover_toggler,.resource_partial .controls_popover_toggler").click(function(){
    	//Hiding some buttons in specific situations
    	$(".article_edit_fragments_container .hidden_on_article_editing").css("display","none");
    	
    	var container = $(this).parents(".resource_partial");
      	var overlay_content = container.find(".tooltip_content").html();
    	container.prepend("<div class='popover_overlay'><div class='overlay_content'>"+overlay_content+"</div></div>");
    	var overlay = container.children(".popover_overlay");
    	overlay.fadeIn();
    	overlay.find(".close, .btn").click(function(){
    		overlay.fadeOut(function(){overlay.remove();});
    	});
    	
    });
}

//-----------Dot dot dot
$(".fragment_summary td.table-value p,.fragment_summary td.table-key p,.fragment_summary ul.summary_hash_container, .thumbnail p").dotdotdot();

$(function(){
	initializeControlsPopovers();
	flashMessages();
	$("li a.create_fragment_button").tooltip({placement:'bottom'});
        $(".load_streamline_button").click(function(){
	    stateful_loading($(this));
	});
});
