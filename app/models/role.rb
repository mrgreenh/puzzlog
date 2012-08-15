# coding: utf-8
class Role < ActiveRecord::Base
  attr_accessible :description, :name
  
  validates :name, presence:true, uniqueness:[case_sensitive:false,message:'This role name has already been used.']
  
  has_many :user_role_relationships, dependent: :destroy
  has_many :users, through: :user_role_relationships, source: :user
end
