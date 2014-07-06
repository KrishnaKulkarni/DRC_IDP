require 'csv'

LOCATIONS = {
 'Village'      => 'Village',
 'Groupement'   => 'Group',
 'Collectivite' => 'Collective',
 'Territoire'   => 'Territory',
 'Province'     => 'Province'  
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