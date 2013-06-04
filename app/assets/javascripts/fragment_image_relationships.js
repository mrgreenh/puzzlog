function addImagesFromBoxConfirmationButton(){
	$("#addItemsFromBoxConfirmationButton").click(function(){
		var selectedImages = {};
		$("#box_resources_list_container .multiple_selection_checkbox").each(function(){
			if(this.checked){
				var imageData = JSON.parse($(this).parents("li").attr("data-image-json"));
				selectedImages[imageData.id]=imageData;
			}
		});
		fragmentImagesInjection(selectedImages);
		closeBoxContainer();
	});
}
