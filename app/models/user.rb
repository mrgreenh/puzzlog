class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :remember_token, :bio, :avatar
    
  before_save { |user| user.email = email.downcase }
  has_secure_password
  
  has_attached_file :avatar,:styles => {:medium => "400x400>", :thumb => "128x128>" }, :source_file_options => { :all => '-auto-orient' }, :default_url=>"/images/application/missing_avatar.png"
  
  validates :password, presence:true, length:{minimum:6}, on: :create
  validates :password_confirmation, presence:true, on: :create

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false, message: "Name already choosen by someone else" }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false, message:"Somebody else is already using this email" }
                    
  validates :bio, presence:true, length:{maximum:500}
  
  validates_attachment :avatar, size: { :in => 0..4.megabytes, message: "The image you uploaded is too heavy! Try with a smaller version." }

  has_many :user_role_relationships, dependent: :destroy
  has_many :roles, through: :user_role_relationships, source: :role
  
  has_many :fragments
  has_many :articles

#Fragment resources
  has_many :fragment_images
  has_many :fragment_sounds
  has_many :fragment_videos
  has_many :fragment_untyped_attachments

  def create_remember_token
    self.update_attribute(:remember_token, SecureRandom.urlsafe_base64)
  end

end
