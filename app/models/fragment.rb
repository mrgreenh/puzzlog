class Fragment < ActiveRecord::Base
  attr_accessible :data, :fragment_type_id, :stand_alone, :name, :public, :publication_date

  validates_presence_of :data
  validates_presence_of :fragment_type_id
  
  has_many :page_fragment_relationships, dependent: :destroy
  has_many :pages, through: :page_fragment_relationships, source: :page
  
  belongs_to :fragment_type
  
  belongs_to :user
  
  #Fragment resources
  has_many :fragment_image_relationships, dependent: :destroy
  has_many :images, through: :fragment_image_relationships, source: :fragment_image
  
  def getSummaryHash
    keys = self.fragment_type.summary_fields.split(",")
    json_data = ActiveSupport::JSON.decode(self.data)
    summaryHash = Hash.new()
    keys.each do |v|
      summaryHash[v] = json_data[v]
    end
    return summaryHash
  end
  
  def as_json(options={})
    result = super(options)
    result[:data] = ActiveSupport::JSON.decode(self.data)
    if self.id.nil?
      result[:id] = ''
    end
    result
  end
end
