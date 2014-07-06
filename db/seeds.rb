# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# connection = ActiveRecord::Base.connection()
# source = File.open "db/testing.sql", "r"
# source.readlines.each do |line|
#   line.strip!
#
#   next if line.empty? # ensure that rows that contains newlines and nothing else does not get processed
#   # line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
#
#   connection.execute line
# end
# source.close

require './read_village_csv'