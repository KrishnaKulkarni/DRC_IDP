class IdpTrajectory < ActiveRecord::Base

	attr_reader :length_stay, :alternate_village_status

	belongs_to :gold_standard_identity, inverse_of: :idp_trajectories

  # Toggle true/false to turn off/on the validation
  # validates_presence_of :stop_number, :province_id, :territory_id, :arrival_from_type, :mode_of_transport,
  #                            message: "rempliseez cette case", if: "true"
  validates_presence_of :stop_number, :province_id, message: "rempliseez cette case"
  validate :village_or_site_or_alt_village_is_present

  attr_accessor :alternate_village_status

  before_save :sanitize_all_blank_attributes

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

  def later_trajectories
    IdpTrajectory.where(gold_standard_identity_id: self.gold_standard_identity_id)
    .where("stop_number > ?", self.stop_number).order(stop_number: :asc)
  end

  def all_trajectories
    IdpTrajectory.where(gold_standard_identity_id: self.gold_standard_identity_id).order(stop_number: :asc)
  end

  def remove_from_chain!
    self.later_trajectories.each do |traj|
      traj.update(stop_number: traj.stop_number - 1)
    end
    self.destroy
  end

  def highest_connected_trajectory
    self.later_trajectories.last
  end

  private

  def village_or_site_or_alt_village_is_present
    unless village_id.present? || site_id.present? || alternate_village.present?
      errors.add(:village_id, "must choose a village, site, or alternate_village")
      errors.add(:site_id, "must choose a village, site, or alternate_village")
      errors.add(:alternate_village, "must choose a village, site, or alternate_village")
    end
  end

# This method will make sure every attribute that is currently set to a blank string (e.g. "")
# will instead be set to nil. This cleans up after erroneous blank string inputs that sometimes come
# in as a result of the form.
  def sanitize_all_blank_attributes
    self.class.column_names.each do |attribute_name|
      attribute_reader_symbol = attribute_name.to_sym
      attribute_writer_symbol = "#{attribute_name}=".to_sym

      # The 'send' method allows you to call call a method on a object by
      # passing that methods name (converted to a symbol)  as an argument.
      self.send(attribute_writer_symbol, nil)  if self.send(attribute_reader_symbol).blank?
    end
  end
end
