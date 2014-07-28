class  IdpTrajectory < ActiveRecord::Base

	attr_reader :length_stay, :alternate_village_status

	belongs_to :identity, inverse_of: :idp_trajectories

	attr_accessor :alternate_village_status

  def self.as_csv
    CSV.generate do |csv|
        csv << column_names
        all.each do |item|
          csv << item.attributes.values_at(*column_names)
        end
    end
  end
  
end
