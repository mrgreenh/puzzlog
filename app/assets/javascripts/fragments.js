
var fragments = null;
$(function(){ 
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
	
	//Controllo del meccanismo di nominazione frammento
	$('.fragment_controls .keep_it_button').tooltip({placement:'bottom'});
	$('.fragment_controls .keep_it_button').popover({
			content: $(this).find(".name_it_tooltip").html(),
			placement: 'top',
			trigger:'manual'
		});
	$('.fragment_controls .keep_it_button').click(function(){
		var id = null;
		id = $(this).attr("fragment_id");
		if(id==null) id='';
		$("#name_fragment_"+id).slideDown();
		$(this).fadeOut(function(){
			$("#save_fragment_"+id).fadeIn();
		});
	});
	
	//Aggiornamento campo data al submit
	$("#new_fragment, .edit_fragment").submit(function(){
		$("#new_fragment #fragment_data, .edit_fragment #fragment_data").val(JSON.stringify(fragments[0].data));
	});

});