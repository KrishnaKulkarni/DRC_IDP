
text =  File.open('AdminLevelsScript.sql').read
text.gsub!("dbo.", "")
text.gsub!("id_province", "province_id")
text.gsub!("id_territoire", "territory_id")
text.gsub!("id_collectivite", "collective_id")
text.gsub!("id_groupement", "group_id")

text.gsub!("territoire", "territories")
text.gsub!("province", "provinces")
text.gsub!("nom", "name")
text.gsub!("collectivite", "collectives")
text.gsub!("groupement", "groups")
text.gsub!("village", "villages")

# text.gsub!("dbo.", "")
# text.gsub!("province", "provinces")
# text.gsub!("nom", "name")
# text.gsub!("territoire", "territories")
# text.gsub!("id_province", "province_id")
# text.gsub!("collectivite", "collectives")
# text.gsub!("territory_id", "territory_id")
# text.gsub!("groupement", "groups")
# text.gsub!("collective_id", "collective_id")
# text.gsub!("village", "villages")
# text.gsub!("id_groupement", "group_id")



File.open("AllLocationsScript.sql", 'w') do |newfile|
   newfile.write(text)
end 