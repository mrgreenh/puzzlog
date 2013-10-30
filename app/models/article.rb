class Article < ActiveRecord::Base
  attr_accessible :public, :publication_date, :title, :user_id, :menu_ordering,:cover_fragment_id
  
  validates :title, presence:true, length:{maximum:160, minimum:3, message: "Enter a title between 3 and 160 characters."}, uniqueness: { case_sensitive: false, message:"Title already used!" }
  validates_presence_of :user_id
  
  has_many :pages, dependent: :destroy
  
  has_many :fragments, through: :pages, source: :fragments

  has_many :menu_entries, dependent: :destroy
  
  belongs_to :user

  def create
    self.pages.build(number:1)
    super
  end
  
  def first_fragment
    if self.pages.any?
      self.pages.order('number ASC').first.fragments.order('ordering_number ASC').first
    end
  end
 
 def cover_fragment
   if not self.cover_fragment_id.nil? and fragment=Fragment.find_by_id(self.cover_fragment_id)
     fragment
   else
     self.first_fragment
   end
 end
 
  def chapters_outline
    result = []
    current_chapter = nil
    sorted_pages = self.pages.order('number ASC')
    sorted_pages.each do |page|
      if not page.name.nil? and page.name.size>0
        result.append({:chapter_title => page.name, :page_number => page.number})
      end
    end
    return result
  end

end
