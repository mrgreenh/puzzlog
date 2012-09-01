module FragmentTypes
  module FragmentTypeTitleParagraph
  def edit_script
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
  
  def view_script
    script=<<EOF
$("#fragment_"+fragment.id+"_view p").html(fragment.data.paragraph);
$("#fragment_"+fragment.id+"_view h1").html(fragment.data.title);
EOF
  end
  
  def edit_elements
    elements =<<EOF
<fieldset>Titolo: <input type="text" class="tit"></fieldset>
<fieldset>Testo: <input type="text" class="par"></fieldset>
EOF

  end
  
  def view_elements
    elements =<<EOF
<h1></h1>
<p>
</p> 
EOF
  end
  
  def stylesheet
    style=<<EOF
&.fragment_view{
    color:$reddish;
    margin:10px auto;
    text-align:center;
    width: auto;
    padding:20px;
    h1 {
      color:#00ff00;
    }
  }
&.fragment_edit {
    font-size:13px;
    color:green;
  } 
EOF
  end
  
  def default_data
    data=<<EOF
{"title":"Titolo d'esempio","paragraph":"Contenuto paragrafo!"} 
EOF
    
  end
  
  def random_data
    "{\"title\":\"#{Faker::Lorem.sentence(rand(1..5))}\",\"paragraph\":\"#{Faker::Lorem.sentence(rand(10..20))}\"}"
  end
end


#-----------------------------------------------------Image Gallery

module FragmentTypeImagesGallery
  def edit_script
    script=<<EOF
$("#fragment_"+fragment.id+"_edit input.tit").val(fragment.data.title);
        $("#fragment_"+fragment.id+"_edit input.tit").keyup(function(){
            fragment.data.title = $(this).val();
        });
EOF
  end
  
  def view_script
    script=<<EOF
$("#fragment_"+fragment.id+"_view .big_image").html($("#fragment_"+fragment.id+"_resources li").first().html());
        $("#fragment_"+fragment.id+"_view p").html($("#fragment_"+fragment.id+"_resources img").attr("title"));
        $("#fragment_"+fragment.id+"_view h3").html(fragment.data.title);
        
        var contatore = 0;
        $("#fragment_"+fragment.id+"_view ul").html("");
        $("#fragment_"+fragment.id+"_resources li").each(function(){
          var image = $(this).html();
          var classe = "";
          if(contatore==0) classe = "selected";
          $("#fragment_"+fragment.id+"_view ul").append("<li class='"+classe+"'>"+image+"</li>");
          $("#fragment_"+fragment.id+"_view li").click(function(){
            $("#fragment_"+fragment.id+"_view li").removeClass("selected");
            $(this).addClass("selected");
            $("#fragment_"+fragment.id+"_view .big_image").html($(this).html());
            $("#fragment_"+fragment.id+"_view .image_description").html($(this).children("img").first().attr("title"));
          });
          contatore ++;
        });
EOF
  end
  
  def edit_elements
    elements =<<EOF
<p>Titolo:</p>
    <input type="text" class="tit" />
    <p> Please add some images to this fragment using the "images" panel over here. </p>
EOF
  end
  
  def view_elements
    elements =<<EOF
<h3></h3>
    <div class="big_image"></div>
    <p class="image_description"></p>
    <ul class="thumbs">
      
    </ul>
EOF
  end
  
  def stylesheet
    style=<<EOF
.fragment_type_1.fragment_view{ /* In realtà il css del container non andrà toccato */
    border-style:solid;
    border-width:1px;
    border-color:#885555;
    color:#885555;
    margin:10px auto;
    text-align:center;
    width: 90%;
    padding:20px;
    overflow:hidden;
  }
  
  .fragment_type_1 .big_image {
    height:300px;
  }
  
  .fragment_type_1 .big_image img{
    max-height:300px;
  }
  
  .fragment_type_1 .thumbs li{
    float:left;
    max-width:30%;
    overflow:hidden;
    height:80px;
  }
  
  .fragment_type_1 .thumbs li.selected{
    border-style:solid;
    border-width:2px;
    border-color:red;
  }
  
  .fragment_type_1 li img{
    min-height:80px;
  }
  
  .fragment_type_1.fragment_edit {
    color:green;
  }
EOF
  end
  
  def default_data
    data=<<EOF
{"title":"Untitled Gallery"}
EOF
    
  end
  
  def random_data
    "{\"title\":\"#{Faker::Lorem.sentence(rand(1..5))}\"}"
  end
end


end