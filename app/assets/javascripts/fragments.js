var fragments = null;
var initialized_fragments = [];
var targetFragment = null; //This is used to understand in which fragment's hash the requested resource has to be added

//Add To Box button -------- Left here just as a reference in case there is the need to change some popover
	// function addToBoxPopover(){
		// $(".add_to_box_button").unbind('click').click(function(){
			// var popover_content = $(this).next("#add_to_box_popover").html();
			// $(this).parents(".popover-content").html(popover_content);
			// $(".popover .form_container button").click(function(){
				// $(this).parents(".popover").hide();
			// });
		// });
	// }
//----------------------------------------------Fragment initialization
function initializeAllFragments(){
	if(fragments[0]!=null&&fragments[0]!=undefined){
		//When the page is rendered all the fragments hash is read and every fragment is fed to a new object of the right type
		$(fragments).each(function(){
			initializeFragment(this);
		});
	}
}
function initializeFragment(fragment){
	var type_id = fragment.fragment_type_id;
	var initialized_frag = new fragment_types[type_id](fragment);
	initialized_fragments.push(initialized_frag); //Initialize object of type fragment_type with data from fragment
	
	//Inject some useful variables in the fragment
	fragment.viewSelector = "#fragment_"+fragment.id+"_view";
	fragment.editSelector = "#fragment_"+fragment.id+"_edit";
	
	if(initialized_frag.initializeView!=undefined) initialized_frag.initializeView();
	//Fragments methods are called after clicking on the view or edit tab
	$("#fragment_"+fragment.id+"_tab a.view_tab_link").each(function(){
		$(this).click(function(){
			if(initialized_frag.view!=undefined) initialized_frag.view();
		});
	});
	$("#fragment_"+fragment.id+"_tab a.edit_tab_link").click(function(){
		if(initialized_frag.edit!=undefined) initialized_frag.edit();
	});
	$("#fragment_"+fragment.id+"_edit").each(function(){
		if(initialized_frag.initializeEdit!=undefined) initialized_frag.initializeEdit();
	});
//-------------------Resources management initialization
	updateResources(fragment);
	//Images
	if(fragment.has_images){
		$("#fragment_"+fragment.id+"_images_upload_button, #fragment_"+fragment.id+"_images_add_button").click(function(){
			targetFragment = fragment;
		});
	}
	//----Initialize edit and view tabs
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

//Initialization
$(function(){ 
	//---------------------------------------Dot dot dot e altre utility
	$(".fragment_summary td.table-value p,.fragment_summary td.table-key p,.fragment_summary ul.summary_hash_container").dotdotdot();
	$(".move_to_page_button, .detach_fragment_button").tooltip({placement:'right'});
	//---------------------------------------Fragments initializer
	initializeAllFragments();
	
	//------------------------------------Fragment controls
	
	//-------------------New Fragment
	//Fragments naming control mechanism
	$('#new_fragment .fragment_controls .keep_it_button').tooltip({placement:'bottom'});
	$('#new_fragment .fragment_controls .keep_it_button').popover({
			content: $(this).find(".name_it_tooltip").html(),
			placement: 'top',
			trigger:'manual'
		});
	$('#new_fragment .fragment_controls .save_to_box_button').click(function(){
		$("#choose_bag").slideDown();
		$("#save_to_box").val("true");
		addNewBagButton();
		$(this).fadeOut(function(){
			$("#save_button").fadeIn();
		});
	});
	
	//Updating data field on submit
	$("#new_fragment, .edit_fragment").submit(function(){
		$("#new_fragment #fragment_data, .edit_fragment #fragment_data").val(JSON.stringify(fragments[0].data));
		$("#new_fragment #fragment_resources_images, .edit_fragment #fragment_resources_images").val(JSON.stringify(fragments[0].images));
	});

});