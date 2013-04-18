var editors={};

$(function(){
	initializeAceEditors();
	initializeResourcesFakers();
	initializeFragmentTypeSaving();
	displayImagesCode();
	setSampleImages();
});

function initializeAceEditors(){
	require("ace/config").set("packaged", false);
	$(".coding_area").each(function(){
		var id = $(this).attr("id");
		var editor = ace.edit(id);
		editors[id]=editor;
		
		editor.setTheme("ace/theme/dawn");
		editor.getSession().setMode("ace/mode/javascript");
		if($(this).hasClass("javascript_code")){
			editor.getSession().setMode("ace/mode/javascript");
		}else if($(this).hasClass("html_code")){
			editor.getSession().setMode("ace/mode/html");
		}else if($(this).hasClass("scss_code")){
			editor.getSession().setMode("ace/mode/scss");
		}else if($(this).hasClass("json_code")){
			editor.getSession().setMode("ace/mode/json");
		}
	});
	
	if($(".coding_area").length>0){//If we are in the right page! ;)
		//Filling editors with fragment's code
		editors["script_editor"].setValue($("#script").val());
		editors["edit_html_editor"].setValue($("#edit_elements").val());
		editors["view_html_editor"].setValue($("#view_elements").val());
		editors["scss_editor"].setValue($("#stylesheet").val());
		editors["default_data_editor"].setValue($("#default_data").val());
		editors["sample_images_editor"].setValue($("#sample_images").val());
	}
	
	//Images JSON capturing
	$("#capture_images_button").click(function(){
		editors["sample_images_editor"].setValue(JSON.stringify(fragments[0].images));
		return false;
	});
}

function initializeResourcesFakers(){
	$(".resources_quantity_field").keyup(function(){
		displayImagesCode();
	});
}

function displayImagesCode(){
	if($("#images").val()>0){
		$("#sample_images_editor").slideDown(function(){
			editors["sample_images_editor"].resize();
		});
	}else{
		$("#sample_images_editor").slideUp();
	}
}

function initializeFragmentTypeSaving(){
	$("#fragment_type_form").submit(function(){
		$("#script").val(editors["script_editor"].getValue());
		$("#edit_elements").val(editors["edit_html_editor"].getValue());
		$("#view_elements").val(editors["view_html_editor"].getValue());
		$("#stylesheet").val(editors["scss_editor"].getValue());
		$("#default_data").val(editors["default_data_editor"].getValue());
		$("#sample_images").val(editors["sample_images_editor"].getValue());
	});
}

function setSampleImages(){
	if($(".coding_area").length>0&&$("#sample_images").val().length>0){ //The first clause checks if we are in the right page
		var images=JSON.parse($("#sample_images").val());
		fragments[0].images = images;
	}
}
