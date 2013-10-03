class MenuEntry < ActiveRecord::Base
  attr_accessible :title, :link_type, :article_id, :order, :user_id, :link_type
end
