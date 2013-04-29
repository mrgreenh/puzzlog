function addNewBagButton(){
	$("#new_bag_modal_form_button").click(function(){
		$(this).replaceWith('<input type="text" name="new_bag_name" id="new_bag_name_modal_form_field" placeholder="Containing..?" \>');
	});
}

function showBagSelector(){
	$("#add_to_box_checkbox").click(function(){
		$("#bag_selector, #new_bag_modal_form_button").toggleClass("hide");
	});
}
