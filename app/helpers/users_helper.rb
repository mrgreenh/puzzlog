module UsersHelper
  
  def is_superadmin?(user=current_user)
    return user && !current_user.roles.find_by_name('superadmin').nil?
  end
  def is_writer?(user=current_user)
    return user && !current_user.roles.find_by_name('writer').nil?
  end
  def is_trustedwriter?(user=current_user)
    return user && !current_user.roles.find_by_name('trustedwriter').nil?
  end
  def is_newbie?(user=current_user)
    return user && !current_user.roles.find_by_name('newbie').nil?
  end
#-------------------Priviledges
  def can_create_users?
    is_superadmin?||!isBlogInitialized?
  end
  
  def can_destroy_user?(user=User.find(params[:id]))
    is_superadmin? && user != current_user
  end
  
  def can_edit_user?(user=User.find(params[:id]))
    (current_user?(user)&&is_newbie?)||is_superadmin? # TODO non funziona se non loggato
  end
  
  def can_view_user?(user=User.find(params[:id]))
    true
  end
  
  def can_edit_user_priviledges?(user=User.find(params[:id]))
    is_superadmin?
  end
end
