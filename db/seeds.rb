# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

#------------------------------------------------Priviledges
#Devono rispecchiare quelli nella migrazione
Role.find_or_create_by_name('superadmin', description: 'He can do simply everything.')
Role.find_or_create_by_name('writer', description: 'He can write posts but he cannot publish them.')
Role.find_or_create_by_name('trustedwriter', description: 'He can write and publish posts.')
Role.find_or_create_by_name('newbie', description: 'He can edit his own profile.')


#------------------------------------------------Amministratore e staff
superadmin = User.create!(name: "Provatore",
             email: "provatore@puzzle.org",
             password: "password",
             password_confirmation: "password",
             bio:Faker::Lorem.sentence(50))
superadmin.user_role_relationships.create(role_id:Role.find_by_name('superadmin').id) 

6.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@puzzle.org"
  password  = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               bio:Faker::Lorem.sentence(40))
end

6.times do |n|
  name  = Faker::Name.name
  email = "example_newbie-#{n+1}@puzzle.org"
  password  = "password"
  user = User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               bio:Faker::Lorem.sentence(40))
  user.user_role_relationships.create(role_id:Role.find_by_name('newbie').id)        
end