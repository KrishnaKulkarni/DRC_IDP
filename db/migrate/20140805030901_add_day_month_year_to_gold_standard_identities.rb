class AddDayMonthYearToGoldStandardIdentities < ActiveRecord::Migration
  def change
    add_column :gold_standard_identities, :year_of_birth, :integer
    add_column :gold_standard_identities, :month_of_birth, :integer
    add_column :gold_standard_identities, :day_of_birth, :integer
  end
end
