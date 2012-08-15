class AddDefaultRoles < ActiveRecord::Migration
  def up
    #Populate the table with default roles
    Role.create(name: 'superadmin', description: 'He can do simply everything.')
    Role.create(name: 'writer', description: 'He can write posts but he cannot publish them.')
    Role.create(name: 'trustedwriter', description: 'He can write and publish posts.')
    Role.create(name: 'newbie', description: 'He can edit his own profile.')
  end

  def down
    execute ("DELETE FROM roles WHERE name='superadmin' OR name='writer' OR name='trustedwriter' OR name='newbie'")
  end
end
