function addNewBagButton(){
	$("#new_bag_modal_form_button").click(function(){
		$(this).replaceWith('<input type="text" name="new_bag_name" id="new_bag_name_modal_form_field" placeholder="Containing..?" \>');
	});
}

function showBagSelector(){
	$("#add_to_box_checkbox").click(function(){
		$(".modal-body #bag_selector, .modal-body #new_bag_modal_form_button").toggleClass("hide");
	});
}

function closeBoxContainer(){
	$(".choose_from_puzzle_box_container, .addFromBoxConfirmationContainer").slideUp(function(){
		$(".choose_from_puzzle_box_container, .addFromBoxConfirmationContainer").remove();
	});
	return false;
}
