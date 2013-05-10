$(function(){
	initializeResourcesControlButtons();
});

function initializeResourcesControlButtons(){
	$("#box_resources_remove_button").click(function(){
		$("#box_resources_form").attr("method","delete");
		$("#box_resources_form").attr("action","/user_box_image_relationships/destroy_multiple");
		$("#box_resources_form").submit();
	});
}

function initializeMoveResourcesControlButton(){
	$("#move_box_resource_confirm_button").click(function(){
		$("#bag_id").val($("#bag_selector").val());
		closeModal();
		$("#box_resources_form").attr("method","put");
		$("#box_resources_form").attr("action","/user_box_image_relationships/update_multiple");
		$("#box_resources_form").submit();
	});
}
