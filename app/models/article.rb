class Article < ActiveRecord::Base
  attr_accessible :public, :publication_date, :title, :user_id
  
  validates :title, presence:true, uniqueness: { case_sensitive: false, message:"Title already used!" }
  
  has_many :pages, dependent: :destroy
  
  belongs_to :user
end
