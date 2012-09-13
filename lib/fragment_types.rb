# coding: utf-8
module FragmentTypes
  module FragmentTypeTitleParagraph
    
  def self.summary_fields
    "title,paragraph"
  end
  
  def self.edit_script
    script=<<EOF
$("#fragment_"+fragment.id+"_edit input.tit").val(fragment.data.title);
$("#fragment_"+fragment.id+"_edit input.par").val(fragment.data.paragraph);
$("#fragment_"+fragment.id+"_edit input.tit").keyup(function(){
  fragment.data.title = $(this).val();
});

$("#fragment_"+fragment.id+"_edit input.par").keyup(function(){
  fragment.data.paragraph = $(this).val();
}); 
EOF
  end
  
  def self.view_script
    script=<<EOF
$("#fragment_"+fragment.id+"_view p").html(fragment.data.paragraph);
$("#fragment_"+fragment.id+"_view h1").html(fragment.data.title);
EOF
  end
  
  def self.edit_elements
    elements =<<EOF
<fieldset>Titolo: <input type="text" class="tit"></fieldset>
<fieldset>Testo: <input type="text" class="par"></fieldset>
EOF

  end
  
  def self.view_elements
    elements =<<EOF
<h1></h1>
<p>
</p> 
EOF
  end
  
  def self.stylesheet
    style=<<EOF
&.fragment_view{
    background-color: $background_color;
    border-style:solid;
    border-width:1px;
    border-color:$third_color;
    color:$foreground_color;
    margin:10px auto;
    text-align:center;
    width: auto;
    padding:20px;
  }
&.fragment_edit {
    font-size:13px;
  }
EOF
  end
  
  def self.default_data
    data=<<EOF
{"title":"Titolo d'esempio","paragraph":"Contenuto paragrafo!"} 
EOF
    
  end
  
  def self.random_data
    "{\"title\":\"#{Faker::Lorem.sentence(rand(1..5))}\",\"paragraph\":\"#{Faker::Lorem.sentence(rand(10..20))}\"}"
  end
end


#-----------------------------------------------------Image Gallery

module FragmentTypeImagesGallery
  
  def self.summary_fields
    "title"
  end
  
  def self.edit_script
    script=<<EOF
$("#fragment_"+fragment.id+"_edit input.tit").val(fragment.data.title);
        $("#fragment_"+fragment.id+"_edit input.tit").keyup(function(){
            fragment.data.title = $(this).val();
        });
EOF
  end
  
  def self.view_script
    script=<<EOF
var images = [];
        $.each(fragment.images, function(index,value){
          images.push(value);
        });
        $("#fragment_"+fragment.id+"_view h3").html(fragment.data.title);
        
        
        if(images.length>0){
        $("#fragment_"+fragment.id+"_view .big_image img").attr("src",images[0].medium);
        $("#fragment_"+fragment.id+"_view p").html(images[0].description);
        }
        
        if(images.length>1){
          var contatore = 0;
          $("#fragment_"+fragment.id+"_view ul.thumbs").html("");
          $(images).each(function(index,image){
            var thumb = '<li id="fragment_thumb_'+image.id+'" class="fragment_image_thumb"><img src="" title=""></li>';
            var classe = "";
            if(contatore==0) classe = "selected";
            
            $("#fragment_"+fragment.id+"_view ul.thumbs").append(thumb);
            
            $("#fragment_"+fragment.id+"_view #fragment_thumb_"+image.id).addClass(classe);
            $("#fragment_"+fragment.id+"_view #fragment_thumb_"+image.id+" img").attr("src",image.thumb);
            $("#fragment_"+fragment.id+"_view #fragment_thumb_"+image.id+" img").attr("title",image.description);
            $("#fragment_"+fragment.id+"_view #fragment_thumb_"+image.id).click(function(){
              $("#fragment_"+fragment.id+"_view li.fragment_image_thumb").removeClass("selected");
              $(this).addClass("selected");
              $("#fragment_"+fragment.id+"_view .big_image img").attr("src",image.medium);
              $("#fragment_"+fragment.id+"_view p").html(image.description);
            });
            contatore ++;
          });
        }
EOF
  end
  
  def self.edit_elements
    elements =<<EOF
<p>Titolo:</p>
    <input type="text" class="tit" />
    <p> Please add some images to this fragment using the "images" panel over here. </p>
EOF
  end
  
  def self.view_elements
    elements =<<EOF
<h3></h3>
    <div class="big_image"><img src="" title="" /></div>
    <p class="image_description"></p>
    <ul class="thumbs">
      
    </ul>
EOF
  end
  
  def self.stylesheet
    style=<<EOF
&.fragment_view{
    border-style:solid;
    background-color:$background_color;
    border-width:1px;
    border-color:$third_color;
    color:$foreground_color;
    margin:10px auto;
    text-align:center;
    width: 90%;
    padding:20px;
    overflow:hidden;
  & .big_image {
    height:300px;
  }
  
  & .big_image img{
    max-height:300px;
  }
  
  & .thumbs{
    overflow:hidden;
  }
  & .thumbs li{
    float:left;
    max-width:30%;
    overflow:hidden;
    height:80px;
  }
  
  & .thumbs li.selected{
    border-style:solid;
    border-width:2px;
    border-color:$third_color;
  }
  
  & li img{
    min-height:80px;
  }
}
  &.fragment_edit {
    background-color:$background_color;
    color:$foreground_color;
  }
EOF
  end
  
  def self.default_data
    data=<<EOF
{"title":"Untitled Gallery"}
EOF
    
  end
  
  def self.random_data
    "{\"title\":\"#{Faker::Lorem.sentence(rand(1..5))}\"}"
  end
end


end