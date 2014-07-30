 module IdpTrajectoriesHelper

  def generate_location_text(trajectory)
    if trajectory.alternate_village
      trajectory.alternate_village
    elsif trajectory.village_id
      Village.find_by(id: trajectory.village_id).name
    elsif trajectory.site_id
      Site.find_by(id: trajectory.site_id).name
    end

  end

  def generate_date_text(trajectory)
    trajectory.departure_date
  end

end