# coding: utf-8
module FragmentTypes
  module FragmentTypeTitleParagraph
    
  def self.summary_fields
    "title,paragraph"
  end
  
  def self.script
    script=<<EOF
this.initializeView = function initializeView(){ //This will be called only once, when the fragment is shown
    this.view();
}
this.initializeEdit = function initializeEdit(){ //This will be called only once, when the fragment's editing controls are shown
    console.log("Edit initialized");
    $(fragment.editSelector+" input.tit").keyup(function(){
        fragment.data.title = $(this).val();
    });
    $(fragment.editSelector+" .par").keyup(function(){
        fragment.data.paragraph = $(this).val();
    });
    this.edit();
}
this.view = function view(){ //Called whenever a user shows the preview tab
    $(fragment.viewSelector+" p").html(fragment.data.paragraph);
    $(fragment.viewSelector+" strong").html(fragment.data.title);
}
this.edit = function edit(){ //Called whenever a user shows the edit tab
    $(fragment.editSelector+" input.tit").val(fragment.data.title);
    $(fragment.editSelector+" .par").val(fragment.data.paragraph);
}
EOF
  end
  
  def self.edit_elements
    elements =<<EOF
<fieldset>
    Titolo: <input type="text" class="tit">
    <p>(You can leave the title empty)</p>
</fieldset>
<fieldset>Testo: 
    <textarea class="par">
        
    </textarea>
</fieldset>
EOF

  end
  
  def self.view_elements
    elements =<<EOF
<strong></strong>
<p>
</p> 
EOF
  end
  
  def self.stylesheet
    style=<<EOF
&.fragment_view{
    background-color: $background_color;
    color:$foreground_color;
    margin:0px auto;
    text-align:left;
    width: auto;
    padding:20px;
    strong{
        font-weight:bold;
        font-size:1.5em;
        color:$third_color;
    }
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
  
  def self.script
    script=<<EOF
this.initializeView = function initializeView(){ //This will be called only once, when the fragment is shown
    this.view();
}
this.initializeEdit = function initializeEdit(){ //This will be called only once, when the fragment's editing controls are shown
    $(fragment.editSelector+" input.tit").val(fragment.data.title);
    $(fragment.editSelector+" input.tit").keyup(function(){
        fragment.data.title = $(this).val();
    });
}
this.view = function view(){ //Called whenever a user shows the preview tab
    var images = [];
    $.each(fragment.images, function(index,value){
      images.push(value);
    });
    $(fragment.viewSelector+" h3").html(fragment.data.title);
    
    
    if(images.length>0){
    $(fragment.viewSelector+" .big_image img").attr("src",images[0].medium);
    $(fragment.viewSelector+" p").html(images[0].description);
    }
    
    if(images.length>1){
      var contatore = 0;
      $(fragment.viewSelector+" ul.thumbs").html("");
      $(images).each(function(index,image){
        var thumb = '<li id="fragment_thumb_'+image.id+'" class="fragment_image_thumb"><img src="" title=""></li>';
        var classe = "";
        if(contatore==0) classe = "selected";
        
        $(fragment.viewSelector+" ul.thumbs").append(thumb);
        
        $(fragment.viewSelector+" #fragment_thumb_"+image.id).addClass(classe);
        $(fragment.viewSelector+" #fragment_thumb_"+image.id+" img").attr("src",image.thumb);
        $(fragment.viewSelector+" #fragment_thumb_"+image.id+" img").attr("title",image.description);
        $(fragment.viewSelector+" #fragment_thumb_"+image.id).click(function(){
          $(fragment.viewSelector+" li.fragment_image_thumb").removeClass("selected");
          $(this).addClass("selected");
          $(fragment.viewSelector+" .big_image img").attr("src",image.medium);
          $(fragment.viewSelector+" p").html(image.description);
        });
        contatore ++;
      });
    }
}
this.edit = function edit(){ //Called whenever a user shows the edit tab
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
    background-color:$background_color;
    color:$foreground_color;
    margin:0px auto;
    text-align:center;
    width: 100%;
    overflow:hidden;
    & h3{
        color:$third_color;
    }
  & .big_image {
    height:100%;
  }
  
  & .big_image img{
    max-height:100%;
  }
  
  & .thumbs{
    overflow:hidden;
  }
  & .thumbs li{
    float:left;
    max-width:30%;
    overflow:hidden;
    height:80px;
    margin:2px;
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