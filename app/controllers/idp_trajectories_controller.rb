class IdpTrajectoriesController < ApplicationController
  include MatchAlgorithm

  before_filter :ensure_signed_in!
  
  def new
    @idp_trajectory = IdpTrajectory.new
    @idp_trajectory_last = IdpTrajectory.last
    if @idp_trajectory_last == nil
      @idp_trajectory_last = @idp_trajectory
      @idp_trajectory_last.gold_standard_identity_id = -1
    end
    @gold_standard_identity = GoldStandardIdentity.last

    if @idp_trajectory_last.gold_standard_identity_id == @gold_standard_identity.id
      @idp_trajectory.stop_number = @idp_trajectory_last.stop_number + 1
      @idp_trajectory.province_id = @idp_trajectory_last.province_id
      @idp_trajectory.territory_id = @idp_trajectory_last.territory_id
      @idp_trajectory.arrival_date = @idp_trajectory_last.arrival_date
    else
      @idp_trajectory.stop_number = 1
      @idp_trajectory.province_id = @gold_standard_identity.province_id
      @idp_trajectory.territory_id = @gold_standard_identity.territory_id
    end

    @header = "Add a Stop pour #{@gold_standard_identity.first_name} #{@gold_standard_identity.last_name}"

    render :new
  end
  
  def show
    render :show
  end

  def create
    @gold_standard_identity = GoldStandardIdentity.last

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

end