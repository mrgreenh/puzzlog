class Article < ActiveRecord::Base
  attr_accessible :public, :publication_date, :title, :user_id
  
  validates :title, presence:true, length:{maximum:160, minimum:3, message: "Enter a title between 3 and 160 characters."}, uniqueness: { case_sensitive: false, message:"Title already used!" }
  validates_presence_of :user_id
  
  has_many :pages, dependent: :destroy
  
  has_many :fragments, through: :pages, source: :fragments
  
  belongs_to :user
  
  def first_fragment
    if self.pages.any?
      self.pages.order('number ASC').first.fragments.order('ordering_number ASC').first
    end
  end
  
  def create
    self.pages.build(number:1,foreground_color:"#000000",background_color:"#ffffff",third_color:"#555555")
    super
  end
  
end
