
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
function updateResources(fragment){
	$("#fragment_"+fragment.id+"_images .thumbnails").html("");
	$.each(fragment.images, function(key,image){
		console.log(image.description);
		var controls = '<a class="close" data-image-id="'+image.id+'">&times;</a>';
		var thumbnail = '<img alt="'+image.description+'" src="'+image.thumb+'"><p>'+image.description+'</p>';
		var thumbnailContainer = '<li data-image-id="'+image.id+'" class="span2 fragment_editor_resource_container" id="fragment_image_'+image.id+'"><div class="fragment_image thumbnail">'+thumbnail+controls+'</div></li>';
		$("#fragment_"+fragment.id+"_images .thumbnails").append(thumbnailContainer);
	});
	$("#fragment_"+fragment.id+"_images .close").click(function(){
		var imageId = $(this).attr("data-image-id");
		$(this).parents("li").slideUp(function(){
			$(this).remove();
		});
		delete(fragment.images[imageId]);
	});
	
}
//Inizializzazione
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
			$("#fragment_"+fragment.id+"_tab a.edit_tab_link").click(function(){
				fragments_methods[type_id].edit(fragment);
			});
//-------------------Resources management initialization
			updateResources(fragment);
			//Images
			if(fragment.has_images){
				$("#fragment_"+fragment.id+"_images_upload_button").click(function(){
					targetFragment = fragment;
				});
			}
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
		//Updating resources fields on submit TODO
		
	});

});