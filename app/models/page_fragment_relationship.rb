class PageFragmentRelationship < ActiveRecord::Base
  attr_accessible :fragment_id, :ordering_number, :page_id
  
  belongs_to :fragment
  belongs_to :page
  
  def destroy
    no_other_relationships = self.fragment.page_fragment_relationships.count==1
    if no_other_relationships&&!self.fragment.stand_alone&&self.fragment.publication_date.nil?
      self.fragment.delete
    end
    relationships = self.page.page_fragment_relationships.where('ordering_number>?',self.ordering_number).order('ordering_number ASC')
    relationships.each do |rel|
      rel.ordering_number -= 1
      rel.save
    end
    super
  end
  
end
