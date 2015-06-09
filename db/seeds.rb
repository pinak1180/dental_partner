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

##-- Practise Codes --##
%w( GHDB WUEI WPEK EHBJ DJUC AZDG KDMD POIU ).each do |code|
  PractiseCode.find_or_create_by!(code: code)
end

##--  --##
