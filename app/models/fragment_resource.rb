class FragmentResource < ActiveRecord::Base
  self.abstract_class = true

  attr_accessible :description, :user_id, :fragment_resource_file, :data
  
  validates_presence_of :user_id
  
  belongs_to :user
  
  def is_public?
    self.fragments.where('public=?',true).any?
  end
  
  def data=(val)
    if val.kind_of? String
      begin
        val = ActiveSupport::JSON.decode(val)
      rescue
        val = {}
      end
    end
    write_attribute(:data, val)
  end
end