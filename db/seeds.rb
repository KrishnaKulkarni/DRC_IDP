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

# require './read_village_csv'

require 'csv'

# -- LOCATIONS --
LOCATIONS = {
 'Village'      => 'Village',
 'Groupement'   => 'Group',
 'Collectivite' => 'Collective',
 'Territoire'   => 'Territory',
 'Province'     => 'Province',  
 'Site'         => 'Site'
}

DESIRED_ATTRIBUTES = {
  "id"              => :id,
  "id_province"     => :province_id, 
  "id_territoire"   => :territory_id, 
  "id_collectivite" => :collective_id, 
  "id_groupement"   => :group_id,
  "nom"             => :name,
  "code"            => :code
}
failure_text = ""

LOCATIONS.each do |(french_loc, english_loc)|
  # puts "-------#{english_loc}------"
  file = File.open("resources/geocsvs/#{french_loc}List.csv")
  CSV.foreach(file.path, headers: true) do |row|
    french_loc_values = row.to_hash
    english_loc_values = {}
    DESIRED_ATTRIBUTES.each do |(french_attr, english_attr)|
      if(french_loc_values[french_attr])
        english_loc_values[english_attr] = french_loc_values[french_attr]
      end
    end
    
    # puts "--ID: #{french_loc_values['id']}"
    create_succeeded = english_loc.constantize.create(english_loc_values)
    unless(create_succeeded)
      failure_text << "#{english_loc} : #{french_loc_values['id']} : #{french_loc_values['nom']}\n"
    end
  end
  
  file.close
end

File.open('db/location_seeding_errors.txt', 'w') { |file| file.write(failure_text) }

# -- LOCATIONS END --

# -- REFERNCE CSVS --

LISTS = {
 'Reason'      => 'Reason'
}

DESIRED_ATTRIBUTES = {
  "id"                  => :id,
  "departure_reason"    => :departure_reason
}
failure_text = ""

LISTS.each do |(french_loc, english_loc)|
  # puts "-------#{english_loc}------"
  file = File.open("resources/#{french_loc}List.csv")
  CSV.foreach(file.path, headers: true) do |row|
    french_loc_values = row.to_hash
    english_loc_values = {}
    DESIRED_ATTRIBUTES.each do |(french_attr, english_attr)|
      if(french_loc_values[french_attr])
        english_loc_values[english_attr] = french_loc_values[french_attr]
      end
    end
    
    # puts "--ID: #{french_loc_values['id']}"
    create_succeeded = english_loc.constantize.create(english_loc_values)
    unless(create_succeeded)
      failure_text << "#{english_loc} : #{french_loc_values['id']} : #{french_loc_values['nom']}\n"
    end
  end
  
  file.close
end

File.open('db/location_seeding_errors.txt', 'w') { |file| file.write(failure_text) }

# -- REFERNCE CSVS END --

# -- USERS ---
User.create!(username: "Andrew")
User.create!(username: "Toly")
User.create!(username: "Hannah")
User.create!(username: "John")
User.create!(username: "Roger")
User.create!(username: "Moise")
User.create!(username: "Adelestine")
User.create!(username: "Benoit")
User.create!(username: "Esperance")
User.create!(username: "Hermanie")
User.create!(username: "Kennedy")