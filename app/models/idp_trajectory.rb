class IdpTrajectory < ActiveRecord::Base

	attr_reader :length_stay, :alternate_village_status

	belongs_to :identity, inverse_of: :idp_trajectories

  # Toggle true/false to turn off/on the validation
  # validates_presence_of :stop_number, :province_id, :territory_id, :arrival_from_type, :mode_of_transport,
  #                              message: "rempliseez cette case", if: "true"

	attr_accessor :alternate_village_status

  def self.as_csv
    CSV.generate do |csv|
        csv << column_names
        all.each do |item|
          csv << item.attributes.values_at(*column_names)
        end
    end
  end

  def prior_trajectories
    IdpTrajectory.where(gold_standard_identity_id: self.gold_standard_identity_id)
    .where("stop_number < ?", self.stop_number).order(stop_number: :asc)
  end
  
end
