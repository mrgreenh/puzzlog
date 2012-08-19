class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :remember_token, :bio, :avatar
    
  before_save { |user| user.email = email.downcase }
  has_secure_password
  
  #has_attached_file :avatar,:styles => {:medium => "400x400>", :thumb => "128x128>" }, :source_file_options => { :all => '-auto-orient' },url: "/images/uploads/avatars/:id/:style/:filename", :path => ":rails_root/public/images/uploads/avatars/:id/:style/:filename", :default_url=>"/images/application/missing_avatar.png"
  has_attached_file :avatar,:styles => {:medium => "400x400>", :thumb => "128x128>" }, :source_file_options => { :all => '-auto-orient' }, :default_url=>"/images/application/missing_avatar.png", :storage => :s3,
    :s3_credentials => {
      :bucket            => ENV['S3_BUCKET_NAME'],
      :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  
  validates :password, presence:true, length:{minimum:6}, on: :create
  validates :password_confirmation, presence:true, on: :create

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false, message: "Name already choosen by someone else" }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false, message:"Somebody else is already using this email" }
                    
  validates :bio, presence:true, length:{maximum:500}

  has_many :user_role_relationships, dependent: :destroy
  has_many :roles, through: :user_role_relationships, source: :role

  def create_remember_token
    self.update_attribute(:remember_token, SecureRandom.urlsafe_base64)
  end

end
