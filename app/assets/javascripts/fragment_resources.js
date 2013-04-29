function addResourceUploaderButton(){
	$(".add_file_field_link").click(function(){
		var uploaderFieldsCounter = 0;
		var form = $(this).parents("form").first();
		if(!(form.find(".resource_uploading_fields li").length>=8)){
			form.find(".resource_uploading_fields").append(uploaderField); //questo è renderizzato nel file della view
			form.find(".resource_uploading_fields li").each(function(){
				uploaderFieldsCounter ++;
				$(this).find(".resource_description_field").attr("name","fragment_resource["+uploaderFieldsCounter+"][description]");
				$(this).find(".resource_description_field").attr("id","fragment_resource_"+uploaderFieldsCounter+"_description");
				
				$(this).find(".resource_file_field").attr("name","fragment_resource["+uploaderFieldsCounter+"][file]");
				$(this).find(".resource_file_field").attr("id","fragment_resource_"+uploaderFieldsCounter+"_file]");
			});
			addResourceUploaderRemover();
		}
	});
}

function addResourceUploaderRemover(){
	$(".remove_upload_button").click(function(){
		$(this).parent().remove();
	});
}


