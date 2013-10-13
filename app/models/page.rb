class Page < ActiveRecord::Base
  attr_accessible :number, :name, :foreground_color, :background_color, :third_color, :article_id
  before_destroy :dont_destroy_if_last_page
  
  validates_presence_of :article_id
  validates :name, length: {maximum:160, message: "Page name must be shorter of 160 chars."}
  validates :background_color, length: {is:7}
  validates :foreground_color, length: {is:7}
  validates :third_color, length: {is:7}
  
  belongs_to :article
  has_many :page_fragment_relationships, dependent: :destroy
  has_many :fragments, through: :page_fragment_relationships, source: :fragment
  
  def ordered_fragments
   Fragment.joins(:page_fragment_relationships).where('page_id=?',self.id).order('ordering_number ASC')
  end
  
  def dont_destroy_if_last_page
    if self.article.pages.count<=1
      false
    end
  end

  def chapter
    
  end
  
end
