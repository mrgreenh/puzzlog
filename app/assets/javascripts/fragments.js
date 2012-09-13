var fragments = null;
var targetFragment = null;
//Se questo non è nullo, la create della risorsa aggiorna l'hash contenuto nell'oggetto

//Add To Box button -------- Lo lascio nel caso serva vedere come cambiare il contenuto della popup al volo
	// function addToBoxPopover(){
		// $(".add_to_box_button").unbind('click').click(function(){
			// var popover_content = $(this).next("#add_to_box_popover").html();
			// $(this).parents(".popover-content").html(popover_content);
			// $(".popover .form_container button").click(function(){
				// $(this).parents(".popover").hide();
			// });
		// });
	// }
//----------------------------------------------Inizializzazione frammento
function initializeAllFragments(){
	if(fragments[0]!=null&&fragments[0]!=undefined){
		//Quando la pagina è renderizzata viene letto l'hash con gli oggetti di ogni frammento, e a seconda del tipo vi associa un oggetto contenente i metodi necessari
		$(fragments).each(function(){
			initializeFragment(this);
		});
	}
}
function initializeFragment(fragment){
	var type_id = fragment.fragment_type_id;
	fragments_methods[type_id].edit(fragment);
	fragments_methods[type_id].view(fragment);
	
	//Faccio si che la view venga aggiornata ad ogni click sulla relativa tab
	$("#fragment_"+fragment.id+"_tab a.view_tab_link").click(function(){
		fragments_methods[type_id].view(fragment);
	});
	$("#fragment_"+fragment.id+"_tab a.edit_tab_link").click(function(){
		fragments_methods[type_id].edit(fragment);
	});
//-------------------Resources management initialization
	updateResources(fragment);
	//Images
	if(fragment.has_images){
		$("#fragment_"+fragment.id+"_images_upload_button, #fragment_"+fragment.id+"_images_add_button").click(function(){
			targetFragment = fragment;
		});
	}
	//----Inizializzo le tab edit e view
	$('#fragment_'+fragment.id+'_tab a').click(function (e) {
		e.preventDefault();
		$(this).tab('show');
	});
}

//------------------------------Resources
//Images
function fragmentImageThumbnail(image){
	var controls = '<a class="detach" data-image-id="'+image.id+'"><i class="icon icon-remove"></i></a>';
	var thumbnail = '<img alt="'+image.description+'" src="'+image.thumb+'"><p>'+image.description+'</p>';
	var thumbnailContainer = '<li data-image-id="'+image.id+'" class="span2 fragment_editor_resource_container" id="fragment_image_'+image.id+'"><div class="fragment_image thumbnail">'+thumbnail+controls+'</div></li>';
	return thumbnailContainer;
}
function fragmentImagesInjection(createdImages){
	if(targetFragment!=undefined&&targetFragment!=null){
		$.extend(targetFragment.images, createdImages);
		updateResources(targetFragment);
		targetFragment = null;
	}
}
function addImageInitialize(){
	$(".modal_index .fragment_image").click(function(){
		$(this).toggleClass("selected");
	});
	$(".modal-body .add_images_from_box_button").click(function(){
		var images = new Object();
		$(".modal_index .fragment_image.selected").each(function(){
			var jsonData = JSON.parse($(this).parents("li").attr("data-image-json"));
			images[jsonData.id] = jsonData;
		});
		fragmentImagesInjection(images);
		closeModal();
	});
};

function updateResources(fragment){
	//-------------------------Images
	$("#fragment_"+fragment.id+"_images .thumbnails").html("");
	$.each(fragment.images, function(key,image){
		$("#fragment_"+fragment.id+"_images .thumbnails").append(fragmentImageThumbnail(image));
	});
	$("#fragment_"+fragment.id+"_images .detach").click(function(){
		var imageId = $(this).parents("li").attr("data-image-id");
		$(this).parents("li").slideUp(function(){
			$(this).remove();
		});
		delete(fragment.images[imageId]);
	});
	
}

//Inizializzazione
$(function(){ 
	//---------------------------------------Dot dot dot e altre utility
	$(".fragment_summary td.table-value p,.fragment_summary td.table-key p").dotdotdot();
	$(".move_to_page_button, .detach_fragment_button").tooltip({placement:'right'});
	//---------------------------------------Fragments initializer
	initializeAllFragments();
	
	//------------------------------------Fragment controls
	
	//-------------------New Fragment
	//Controllo del meccanismo di nominazione frammento
	$('#new_fragment .fragment_controls .keep_it_button').tooltip({placement:'bottom'});
	$('#new_fragment .fragment_controls .keep_it_button').popover({
			content: $(this).find(".name_it_tooltip").html(),
			placement: 'top',
			trigger:'manual'
		});
	$('#new_fragment .fragment_controls .keep_it_button').click(function(){
		$("#new_fragment #fragment_stand_alone").val(true);
		$("#name_fragment").slideDown();
		$(this).fadeOut(function(){
			$("#save_fragment").fadeIn();
		});
	});
	
	//Aggiornamento campo data al submit
	$("#new_fragment, .edit_fragment").submit(function(){
		$("#new_fragment #fragment_data, .edit_fragment #fragment_data").val(JSON.stringify(fragments[0].data));
		$("#new_fragment #fragment_resources_images, .edit_fragment #fragment_resources_images").val(JSON.stringify(fragments[0].images));
	});

});