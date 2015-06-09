# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

##-- Access Levels --##
(1..6).to_a.each do |code|
  AccessLevel.find_or_create_by!(level: code)
end
puts "----Added AccessLevels ----"

##-- Practise Codes --##
%w( GHDB WUEI WPEK EHBJ DJUC AZDG KDMD POIU ).each do |code|
  PractiseCode.find_or_create_by!(code: code)
end
puts "----Added PractiseCodes ----"

##-- Departments --##
%w( legal marketing accounts clinics medical head-office sales outsourced ).each do |name|
  Department.find_or_create_by!(name: name)
end
puts "----Added Departments ----"

##-- Positions --##
%w( manager supervisor dentist assistant copywriter developer adminstrator hygenist ).each do |name|
  Position.find_or_create_by!(name: name)
end
puts "----Added Positions ----"

##-- Admin User --##
user          = User.find_or_initialize_by(email: "admin@dp.com")
user.password = "admin@dp"
user.admin    = true
user.save
puts "----Admin user created----"
