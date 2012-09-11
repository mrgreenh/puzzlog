class Page < ActiveRecord::Base
  attr_accessible :number, :name, :foreground_color, :background_color, :third_color, :article_id
  
  validates_presence_of :article_id
  validates :name, length: {maximum:160, message: "Page name must be shorter of 160 chars."}
  
  belongs_to :article
  has_many :page_fragment_relationships, dependent: :destroy
  has_many :fragments, through: :page_fragment_relationships, source: :fragment
  
  def ordered_fragments
   Fragment.joins(:page_fragment_relationships).where('page_id=?',self.id).order('ordering_number ASC')
  end
  
end
