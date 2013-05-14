function addFragmentsFromBoxConfirmationButton(){
	$("#addItemsFromBoxConfirmationButton").click(function(){
		$("#box_resources_form").attr("method","post");
		$("#box_resources_form").attr("action","/page_fragment_relationships");
		$("#box_resources_form").submit();
		closeBoxContainer();
	});
}
