class IdpTrajectoriesController < ApplicationController
  before_filter :ensure_signed_in!

  def new
    @idp_trajectory = IdpTrajectory.new(trajectory_attributes)
    @header = print_header
    @prior_trajectories = @idp_trajectory.prior_trajectories

    render :new
  end

  def show
    @prior_trajectory = IdpTrajectory.find_by(id: session[:last_trajectory_id])
    @prior_trajectories = IdpTrajectory.where(gold_standard_identity_id: @prior_trajectory.gold_standard_identity_id)

    render :show
  end

  def create
    @gold_standard_identity = GoldStandardIdentity.last

    @idp_trajectory = IdpTrajectory.new(idp_trajectory_params)
    @idp_trajectory.recorded_by = session[:username]
    @idp_trajectory.recorded_in_village = session[:location]
    @idp_trajectory.gold_standard_identity_id = session["last_registered_identity_id"]
    @idp_trajectory.departure_date = handle_length_stay!(@idp_trajectory.departure_date)

    if @idp_trajectory.save
      flash[:status] = "Successful entry of Stop ##{@idp_trajectory.stop_number}
                        pour #{@gold_standard_identity.first_name} #{@gold_standard_identity.last_name}."
      flash[:status_color] = "success-green"
      # # These lines update today's csv
      @idp_trajectories = IdpTrajectory.where("created_at > ?", Date.today).where("recorded_by = ?", session[:username]).where("recorded_in_village = ?", session[:location])
      @idp_trajectories = @idp_trajectories.order(id: :asc)
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

  def edit
    @idp_trajectory = IdpTrajectory.find(params[:id])
    @header = print_header
    @prior_trajectories = @idp_trajectory.all_trajectories

    render :edit
  end

  def update
    @gold_standard_identity = GoldStandardIdentity.last
    @idp_trajectory = IdpTrajectory.find(params[:id])
    @idp_trajectory.recorded_by = session[:username]
    @idp_trajectory.recorded_in_village = session[:location]
    @idp_trajectory.gold_standard_identity_id = session["last_registered_identity_id"]
    @idp_trajectory.departure_date = handle_length_stay!(@idp_trajectory.departure_date)

    if @idp_trajectory.update(idp_trajectory_params)
      flash[:status] = "Succesful edit of Stop ##{@idp_trajectory.stop_number}
                        pour #{@gold_standard_identity.first_name} #{@gold_standard_identity.last_name}."
      flash[:status_color] = "success-green"

      # # These lines update today's csv
      @idp_trajectories = IdpTrajectory.where("created_at > ?", Date.today).where("recorded_by = ?", session[:username]).where("recorded_in_village = ?", session[:location])
      @idp_trajectories = @idp_trajectories.order(id: :asc)
      File.open("exports/idp_trajectory_stops_#{session[:username]}_C#{session[:computer_number]}_#{session[:location]}_#{Date.today}.csv",
       'w') { |file| file.write(@idp_trajectories.as_csv) }

      redirect_to idp_trajectory_url(@idp_trajectory)
    else
      flash.now[:status] = "Erreur d'enregistrement"
      flash.now[:status_color] = "failure-red"
      render :edit
    end
  end

  def trajectory_form
    @idp_trajectory = IdpTrajectory.new
    render "_trajectory_form", :layout => false
  end

  def handle_length_stay!(dep_date)
    @length_stay = params[:idp_trajectory]["length_stay"]
    @departure_date = dep_date

    if @length_stay.present?
      @departure_date = IdpTrajectory.last["departure_date"] + @length_stay.to_i
    end
    @departure_date
  end

  def generate_link_text
    @link_text
    if alternate_village != nil
      @link_text = alternate_village
    elsif site_id == nil
      @link_text = Village.where("id = #{trajectory.village_id}")[0]["name"]
    elsif village_id == nil
      @link_text = Site.where("id = #{trajectory.site_id}")[0]["name"]
    end
    @link_text
  end

  def idp_trajectory_params
    params.require(:idp_trajectory).permit(
    :stop_number, :departure_date, :mode_of_transport, :arrival_from_type,
    :village_id, :site_id, :territory_id, :province_id,
    :alternate_village, :alternate_village_status, :is_temporary_site)
  end

  private
  def store_trajectory_in_cache(idp_trajectory)
    session[:last_trajectory_id] = idp_trajectory.id
  end

  def trajectory_attributes
    # Note that the checks about gold_standard_identity_id matching the id of the last gold standard identity
    # are redundant. As specified in the #create action, whenever a trajectory is created in the app,
    # it is only done by setting it's gold standard id to be the id of the last GoldStandardIdentity.
    # So, our scenarios are (A) we have just created a prior trajectory through the app, (B) we are creating
    # our first new trajectory after having created a gold standard identity, and (C) we are jumping straight to
    # this form.

    if session[:last_trajectory_id]
      attributes_via_last_trajectory
    elsif session[:last_registered_identity_id]
      attributes_via_gold_standard_identity
    else
      {}
    end
  end

  def attributes_via_last_trajectory
    new_attributes = IdpTrajectory.find(session[:last_trajectory_id]).attributes
      .slice('province_id', 'departure_date',
       'stop_number', 'gold_standard_identity_id')
    new_attributes['stop_number'] += 1
    new_attributes
  end

  def attributes_via_gold_standard_identity
    GoldStandardIdentity.find(session[:last_registered_identity_id]).attributes
    .slice("province_id", "gold_standard_identity_id").merge({"stop_number" => 0 })
  end

  def print_header
    if lrii = session[:last_registered_identity_id]
      gsi = GoldStandardIdentity.find(lrii)
      first_name, last_name = gsi.first_name, gsi.last_name
    else
      first_name, last_name = "Unregistered", "Person"
    end
    "Enregister un arret pour #{first_name} #{last_name}"
  end
end