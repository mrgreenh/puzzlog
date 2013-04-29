class Bag < ActiveRecord::Base
    attr_accessible :name, :user_id
    
    validates_presence_of :name, :user_id
    validates_uniqueness_of :user_id, scope: :name
    
    belongs_to :user
    
    has_many :user_box_image_relationships
    has_many :user_box_sound_relationships
    has_many :user_box_video_relationships
    has_many :user_box_untyped_attachment_relationships
    has_many :user_box_fragment_relationships
    
    has_many :box_images, through: :user_box_image_relationships, source: :fragment_image
    has_many :box_sounds, through: :user_box_sounds_relationships, source: :fragment_sound
    has_many :box_videos, through: :user_box_video_relationships, source: :fragment_video
    has_many :box_untyped_attachments, through: :user_box_untype_attachment_relationships, source: :fragment_untyped_attachment
    has_many :box_fragments, through: :user_box_fragment_relationships, source: :fragment
end
