class ChangeTrustedwriterToPublisher < ActiveRecord::Migration
  def up
    role = Role.find_by_name('trustedwriter')
    role.update_attributes(name: 'publisher', description: 'He can approve (publish) posts.')
  end

  def down
    role = Role.find_by_name('publisher')
    role.update_attributes(name: 'trustedwriter', description: 'He can write and publish posts.')
  end
end
