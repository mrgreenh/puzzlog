class Article < ActiveRecord::Base
  attr_accessible :public, :publication_date, :title, :user_id
  
  validates :title, presence:true, length:{maximum:160, minimum:3, message: "Enter a title between 3 and 160 characters."}, uniqueness: { case_sensitive: false, message:"Title already used!" }
  
  
  has_many :pages, dependent: :destroy
  
  has_many :fragments, through: :pages, source: :fragments
  
  belongs_to :user
end
