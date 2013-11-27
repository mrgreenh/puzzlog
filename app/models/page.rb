class Page < ActiveRecord::Base
  attr_accessible :number, :name, :article_id, :theme_id
  
  validates_presence_of :article_id
  validates :name, length: {maximum:160, message: "Page name must be shorter of 160 chars."}
  
  belongs_to :article
  belongs_to :theme
  has_many :page_fragment_relationships, dependent: :destroy
  has_many :fragments, through: :page_fragment_relationships, source: :fragment
  
  def ordered_fragments
   Fragment.joins(:page_fragment_relationships).where('page_id=?',self.id).order('ordering_number ASC')
  end

#This might cause a bug where a deleted article doesn't delete all its pages  
#  def dont_destroy_if_last_page
#    if self.article.pages.count<=1
#      false
#    end
#  end

  def chapter
    page_chapter = nil
    chapters = self.article.chapters_outline
    chapters.each do |chapter|
      break if chapter[:page_number]>self.number
      page_chapter = chapter[:chapter_title] if chapter[:page_number]<=self.number
    end
    return page_chapter
  end
  
  def theme
    super || Theme.default
  end
  
end
