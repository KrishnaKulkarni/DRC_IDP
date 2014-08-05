FactoryGirl.define do
  factory :gold_standard_identity do
    first_name "John"
    last_name  "Hangi"
    sex "Male"
    household_size 4
    province_id 1 #=> "Nord-Kivu"
    territory_id 6 #=> "NYIRAGONGO"
    collective_id 25 #=> "BUKUMU"
    group_id 86 #=> "KIBUMBA"
    village_id 2037 #=> " BUSHANA"
    alternate_village nil
    head_of_household_status "1"
    village_of_origin "Goma"

    date_of_birth nil
  end
end