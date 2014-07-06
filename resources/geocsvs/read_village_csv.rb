require 'csv'

file = File.open('VillageList.csv', "r")


VILLAGE_ATTRIBUTES = {
    "id_groupement"  => :group_id,
    "nom"  => :name,
    "created_on"  => :created_at,
    "code"  => :code
}

failures = []

CSV.foreach(file.path, headers: true) do |row|
  village_attrs = row.to_hash
  translated_attrs = {}
  VILLAGE_ATTRIBUTES.each do |(french_attr, english_attr)|
    if(village_attrs[french_attr])
      translated_attrs[english_attr] = village_attrs[french_attr]
    end
  end
  
  create_succeeded = Village.create(translated_attrs)
  unless(create_succeeded)
    failures << [village_attrs['id'], village_attrs['nom']]
  end
end
file.close
p failures