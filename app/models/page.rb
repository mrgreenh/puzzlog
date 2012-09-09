class Page < ActiveRecord::Base
  attr_accessible :number, :name, :foreground_color, :background_color, :third_color
  
  belongs_to :article
  has_many :page_fragment_relationships, dependent: :destroy
  has_many :fragments, through: :page_fragment_relationships, source: :fragment
  
  def ordered_fragments
   Fragment.joins(:page_fragment_relationships).where('page_id=?',self.id).order('ordering_number ASC')
  end
  
  def destroy
    # TODO fare l'override per eliminare propri frammenti non pubblicati o stand_alone
    super
  end
  
end
