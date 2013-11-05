class MenuEntry < ActiveRecord::Base
  attr_accessible :title, :link_type, :article_id, :order, :user_id, :link_type
  belongs_to :user
end
