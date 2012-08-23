//Fragments initializer
var fragments = null;
$(function(){ //Quando la pagina è renderizzata viene letto l'hash con gli oggetti di ogni frammento, e a seconda del tipo vi associa un oggetto contenente i metodi necessari
		if(fragments!=null){
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
	});