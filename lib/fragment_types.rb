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
    border-style:solid;
    border-width:1px;
    border-color:$reddish;
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

end