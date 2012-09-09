class PageFragmentRelationship < ActiveRecord::Base
  attr_accessible :fragment_id, :ordering_number, :page_id
  
  belongs_to :fragment
  belongs_to :page
  
  def destroy
    logger.debug "Qui ci passo"
    no_other_relationships = self.fragment.page_fragment_relationships.count==1
    logger.debug self.fragment.page_fragment_relationships.count
    logger.debug no_other_relationships
    logger.debug !self.fragment.stand_alone
    logger.debug self.fragment.publication_date.nil?
    if no_other_relationships&&!self.fragment.stand_alone&&self.fragment.publication_date.nil?
      logger.debug "frammento in distruzione"
      self.fragment.delete
       logger.debug "frammento distrutto"
    end
    super
  end
  
end
