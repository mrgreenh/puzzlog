class Theme < ActiveRecord::Base
  attr_accessible :foreground_color, :background_color, :third_color, :fourth_color, :stylesheet, :name, :preview_image
  has_many :pages
  
  def self.default
    Theme.new(:background_color=>"#ffffff", :foreground_color=>"#000000", :third_color=>"#666666", :fourth_color=>"#bbbbbb", :name=>"Default", :stylesheet=>"")
  end
  
  def getSCSSVariables
    "$background_color: #{self.background_color};$foreground_color: #{self.foreground_color};$third_color: #{self.third_color};$fourth_color: #{self.fourth_color};"
  end

  def previewImageAddress
    "/images/application/themes/"+self.preview_image
  end
  
end
