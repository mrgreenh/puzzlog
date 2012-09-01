
var fragments = null;

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
	
$(function(){ 
	//---------------------------------------Dot dot dot
	$(".fragment_summary td.table-value p,.fragment_summary td.table-key p").dotdotdot();
	//---------------------------------------Fragments initializer
	if(fragments!=null){
		//Quando la pagina è renderizzata viene letto l'hash con gli oggetti di ogni frammento, e a seconda del tipo vi associa un oggetto contenente i metodi necessari
		$(fragments).each(function(){
			var type_id = this.fragment_type_id;
			var fragment = this;
			fragments_methods[type_id].edit(fragment);
			fragments_methods[type_id].view(fragment);
			
			//Faccio si che la view venga aggiornata ad ogni click sulla relativa tab
			$("#fragment_"+fragment.id+"_tab a.view_tab_link").click(function(){
				fragments_methods[type_id].view(fragment);
			});
			
			//----Inizializzo le tab edit e view
			$('#fragment_'+fragment.id+'_tab a').click(function (e) {
  				e.preventDefault();
  				$(this).tab('show');
			});
		});
	}
	
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
	});

});