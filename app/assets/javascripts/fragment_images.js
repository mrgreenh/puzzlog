var mediaFragmentReg = /#xywh\=percent\:[0-9]+,[0-9]+,[0-9]+,[0-9]+/i;

function initializeNewImageSearch(){
	initializeSocialSearch();
	addNewBagButton();
	showBagSelector();
	
	//Google search
	initializeGoogleSearch();
	
}

//-----------------------------------------------------------Social Search
function initializeSocialSearch(){
	$("#search_on_social_networks_button").click(function(){
		if($("input#new_image_search").val().length>0&&!$(this).hasClass("disabled")){
			$("#search_on_social_networks_button, #search_on_google_images_button").addClass("disabled");
			$("#new_image_search_results_container").html("<div class='alert alert-success'>Querying Facebook, Flickr, Google Plus, Instagram, Myspace, Twitter... This might take some seconds ...</div>");
			var query = $("input#new_image_search").val();
			$.ajax({
			  dataType: "json",
			  url: "http://eventmedia.eurecom.fr/media-server/search/combined/"+encodeURIComponent(query),
			  success:function(data){
			  	showImageSearchResults(data,"mediaserver");
			  }
			});
		}
	});
}
function showImageSearchResults(data,dataSource){
	$("#new_image_search_results_container").html("<ul class='thumbnails'></ul>");
	var results = parseImageSearchResults(data,dataSource);
	var counter = 0;
	$.each(results,function(){
		var img = "<img src='"+this.thumbUrl+"'/>";
		var caption = "<p>"+this.description+"</p>";
		var checkbox = '<input type="checkbox" class="multiple_selection_checkbox" name="search_results[]" value="" />';
		var resultHTML = "<li class='resource_partial' id='image_search_result_"+counter+"'><div class='image_search_result_container thumbnail'>"+img+caption+"</div>"+checkbox+"</li>";
		$("#new_image_search_results_container ul").append(resultHTML);
		$("#image_search_result_"+counter+" .multiple_selection_checkbox").val(JSON.stringify(this));
		counter++;
	});
	$("#search_on_social_networks_button, #search_on_google_images_button").removeClass("disabled");
}

//-----------------------------------------------------------Google Search
function initializeGoogleSearch(){
	$("#search_on_google_images_button").click(function(){
		if($("input#new_image_search").val().length>0&&!$(this).hasClass("disabled")){
			$("#search_on_social_networks_button, #search_on_google_images_button").addClass("disabled");
			$("#new_image_search_results_container").html("<div class='alert alert-success'>Querying Google... ...</div>");
			var query = $("input#new_image_search").val();
			$.ajax({
			  dataType: "json",
			  url: "https://www.googleapis.com/customsearch/v1?key=AIzaSyBUqlpqXeRQzuXSC0sFuKoOGiGb4PbmrrU&cx=014696709631244279916:wshv_v_wnoy&q="+encodeURIComponent(query)+"&searchType=image&fileType=jpg&imgSize=large&imgSize=xlarge&alt=json",
			  success: function(data){
			  	showImageSearchResults(data.items,"google");
			  }
			});	
		}
	});
}

//Function that parses the result in a more common schema
function parseImageSearchResults(data,dataSource){
	var results = [];
	var format = /\.(gif|jpg|png|tiff)$/i;
	if(dataSource=="google"){
		$.each(data,function(){
			var result = new Object();
			result.dataSource = "google";
			result.thumbUrl = this.image.thumbnailLink;
			result.originalUrl = this.link;
			result.sourceUrl = this.image.contextLink;
			result.socialInteractions = null;
			result.description = this.title;
			if(format.test(result.originalUrl)) results.push(result);
		});
	}else if(dataSource=="mediaserver"){
		//Iterate through social networks
		$.each(data,function(sn,items){
			//Iterate through items
			$.each(items,function(){
				if(this.type=="photo"){
					var result = new Object();
					result.dataSource = sn;
					result.thumbUrl = this.posterUrl;
					result.originalUrl = this.mediaUrl;
					result.sourceUrl = this.micropostUrl;
					if(this.socialInteractions!=undefined)result.socialInteractions = this.socialInteractions;
					if(this.micropost!=undefined) result.description = this.micropost.plainText.substring(0,100);
					if(this.micropost!=undefined&&this.micropost.plainText.length>60) result.description+="..."; //Adding some dots at the end of the description
					if(format.test(result.thumbUrl)&&format.test(result.originalUrl)) results.push(result);
				}
			});
		});
	}
	return results;
}

//Media fragment functionalities
function getImageMediaFragmentCoordinatesButton(){
	$("#apply_image_media_fragment_button").click(function(){
		parseMediaFragment();
		return false;
	});
	$("#remove_image_media_fragment_button").click(function(){
		removeImageMediaFragment();
		return false;
	});
}

function parseMediaFragment(){
		var mediaFragmentParameters = "#xywh=percent:";
		var x = $(".edit_fragment_image input#x").val();
		if(isNaN(x)||x>100||x<0) x=0;
		var y = $(".edit_fragment_image input#y").val();
		if(isNaN(y)||y>100||y<0) y=0;
		var w = $(".edit_fragment_image input#w").val();
		if(isNaN(w)||w>100||w<0||w>(100-x)) w=100;
		var h = $(".edit_fragment_image input#h").val();
		if(isNaN(h)||h>100||h<0||h>(100-y)) h=100;
		var oldURI = $(".edit_fragment_image img").attr("data-original-uri");
		if(oldURI==undefined) oldURI = $(".edit_fragment_image img").attr("src");
		var newMediaFragment = mediaFragmentParameters+x+","+y+","+w+","+h;
		var newURI = oldURI.split(mediaFragmentParameters)[0]+newMediaFragment;
		$(".edit_fragment_image img").attr("src",newURI);
		$(".edit_fragment_image img").attr("data-original-uri",newURI);
		if(mediaFragmentReg.test(newURI)) $(".edit_fragment_image #fragment_image_media_fragment").val(newMediaFragment);
		else $(".edit_fragment_image #fragment_image_media_fragment").val("");
		$(".edit_fragment_image img").attr("style","");
		applyImageMediaFragments(".edit_fragment_image img");
		updateMediaFragmentFields();
}

function updateMediaFragmentFields(){
	var mediaFragmentValue = $(".edit_fragment_image #fragment_image_media_fragment").val();
	if(mediaFragmentReg.test(mediaFragmentValue)){ //Parse media fragment already applied to image
		var coordinates = mediaFragmentValue.split(":")[1].split(",");
		var i=0;
		$(".edit_fragment_image input.media_fragment_form").each(function(){
			$(this).val(coordinates[i]);
			i++;
		});
	}
}

function removeImageMediaFragment(){
	$("#fragment_image_media_fragment").val("");
	$(".edit_fragment_image .media_fragment_form").val("");
	parseMediaFragment();
}
