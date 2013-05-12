function initializeNewImageSearch(){
	initializeSocialSearch();
	initializeGoogleSearch();
}

function initializeSocialSearch(){
	$("#search_on_social_networks_button").click(function(){
		$(".new_image_search_results_container").html("<p>Querying Facebook, Flickr, Google Plus, Instagram, Myspace, Twitter... This might take some seconds.</p>");
		var query = $("input#new_image_search").val();
		$.ajax({
		  dataType: "json",
		  url: "http://eventmedia.eurecom.fr/media-server/search/combined/"+encodeURIComponent(query),
		  success: function(data){
		  	console.log(data);
		  	$(".new_image_search_results_container").html(data);
		  }
		});
	});
}
function initializeGoogleSearch(){
	$("#search_on_google_images_button").click(function(){
		alert("Under construction");
	});
}
