class IdpTrajectoriesController < ApplicationController
  include MatchAlgorithm

  before_filter :ensure_signed_in!
  
  def new
    # Refactored your lines. See the private methods defined below/elsewhere.
    # ===========
    @idp_trajectory = IdpTrajectory.new(trajectory_attributes)
    @header = print_header

    render :new
  end

  def show
    render :show
  end

  def create
    @gold_standard_identity = GoldStandardIdentity.last
    @p.i
    @idp_trajectory = IdpTrajectory.new(idp_trajectory_params)
    @idp_trajectory.recorded_by = session[:username]
    @idp_trajectory.recorded_in_village = session[:location]
    @idp_trajectory.gold_standard_identity_id = session["last_registered_identity_id"]
    if @idp_trajectory.save
      flash[:status] = "Succesful entry of Stop ##{@idp_trajectory.stop_number}
                        pour #{@gold_standard_identity.first_name} #{@gold_standard_identity.last_name}."
      flash[:status_color] = "success-green"

      # # These lines update today's csv
      @idp_trajectories = IdpTrajectory.where("created_at > ?", Date.today)
      File.open("exports/idp_trajectory_stops_#{session[:username]}_C#{session[:computer_number]}_#{session[:location]}_#{Date.today}.csv",
       'w') { |file| file.write(@idp_trajectories.as_csv) }

      # A method for storing the newly created trajectory. Defined below in this file.
      store_trajectory_in_cache(@idp_trajectory)

      redirect_to idp_trajectory_url(@idp_trajectory)
    else
      flash.now[:status] = "Erreur d'enregistrement"
      flash.now[:status_color] = "failure-red"
      render :new
    end
  end

  def trajectory_form
    @idp_trajectory = IdpTrajectory.new
    render "_trajectory_form", :layout => false
  end
  
  def idp_trajectory_params
    params.require(:idp_trajectory).permit(
    :stop_number, :arrival_date, :mode_of_transport,
    :village_id, :group_id, :collective_id, :territory_id, :province_id,
    :alternate_village, :alternate_village_status)
  end

  private
  def store_trajectory_in_cache(idp_trajectory)
    session[:last_trajectory] = idp_trajectory
  end

  def trajectory_attributes
    # Note that the checks about gold_standard_identity_id matching the id of the last gold standard identity
    # are redundant. As specified in the #create action, whenever a trajectory is created in the app,
    # it is only done by setting it's gold standard id to be the id of the last GoldStandardIdentity.
    # So, our scenarios are (A) we have just created a prior trajectory through the app, (B) we are creating
    # our first new trajectory after having created a gold standard identity, and (C) we are jumping straight to
    # this form.

    if session[:last_trajectory]
      attributes_via_last_trajectory
    elsif session[:last_registered_identity_id]
      attributes_via_gold_standard_identity
    else
      {}
    end
  end

  def attributes_via_last_trajectory
    new_attributes = session[:last_trajectory].attributes
      .slice('province_id', 'territory_id', 'arrival_date', 'stop_number')
    new_attributes['stop_number'] += 1
    new_attributes
  end

  def print_header
    if lrii = session[:last_registered_identity_id]
      gsi = GoldStandardIdentity.find(lrii)
      first_name, last_name = gsi.first_name, gsi.last_name
    else
      first_name, last_name = "Unregistered", "Person"
    end
    "Add a Stop pour #{first_name} #{last_name}"
  end

  def attributes_via_gold_standard_identity
    GoldStandardIdentity.find(session[:last_registered_identity_id]).attributes
    .slice("province_id", "territory_id").merge({"stop_number" => 1 })
  end
end