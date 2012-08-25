# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

include FragmentTypes::FragmentTypeTitleParagraph
include ActionView::Helpers::JavaScriptHelper

def randomDateTime
  DateTime::parse(rand(1..12).to_s+'/'+rand(1..12).to_s+'/'+rand(2010..2013).to_s+' 20:30')
end
#------------------------------------------------Priviledges
#Devono rispecchiare quelli nella migrazione
Role.find_or_create_by_name('superadmin', description: 'He can do simply everything.')
Role.find_or_create_by_name('writer', description: 'He can write posts but he cannot publish them.')
Role.find_or_create_by_name('publisher', description: 'He can approve (publish) posts.')
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

#--------------------------------------------Tipi frammento (implementare moduli sopra)
FragmentType.create(edit_elements:FragmentTypes::FragmentTypeTitleParagraph.edit_elements,
                    view_elements:FragmentTypes::FragmentTypeTitleParagraph.view_elements,
                    edit_script:FragmentTypes::FragmentTypeTitleParagraph.edit_script,
                    view_script:FragmentTypes::FragmentTypeTitleParagraph.view_script,
                    stylesheet:FragmentTypes::FragmentTypeTitleParagraph.stylesheet,
                    default_data:FragmentTypes::FragmentTypeTitleParagraph.default_data,
                    name:"Title and Paragraph");

#--------------------------------------------Articoli e frammenti slegati
User.all.each do |user|
  rand(1..12).times do |n|
    user.articles.create(title:Faker::Lorem.sentence(rand(1..6)))
  end
  rand(1..12).times do |n|
    datetime = randomDateTime
    user.fragments.create(name:Faker::Lorem.sentence(rand(1..6)), fragment_type_id:FragmentType.first.id, stand_alone:false, public:false, data:FragmentTypes::FragmentTypeTitleParagraph.random_data)
    datetime = randomDateTime
    user.fragments.create(name:Faker::Lorem.sentence(rand(1..6)), fragment_type_id:FragmentType.first.id, stand_alone:true, public:false, data:FragmentTypes::FragmentTypeTitleParagraph.random_data)
    datetime = randomDateTime
    user.fragments.create(name:Faker::Lorem.sentence(rand(1..6)), fragment_type_id:FragmentType.first.id, stand_alone:false, public:true, publication_date:datetime, data:FragmentTypes::FragmentTypeTitleParagraph.random_data)
    datetime = randomDateTime
    user.fragments.create(name:Faker::Lorem.sentence(rand(1..6)), fragment_type_id:FragmentType.first.id, stand_alone:false, public:false, publication_date:datetime, data:FragmentTypes::FragmentTypeTitleParagraph.random_data)
  end
end


