class IdpTrajectoriesController < ApplicationController
  include MatchAlgorithm

  before_filter :ensure_signed_in!
  
  def new
    @idp_trajectory = IdpTrajectory.new
    render :new
  end
  
  def create
    @gold_standard_identity = GoldStandardIdentity.last

    @idp_trajectory = IdpTrajectory.new(idp_trajectory_params)
    @idp_trajectory.recorded_by = session[:username]
    @idp_trajectory.recorded_in_village = session[:location]
    @idp_trajectory.gold_standard_identity_id = @gold_standard_identity[:id]
    if @idp_trajectory.save
      flash[:status] = "Succesful enter of stop #{@idp_trajectory.stop_number}
                        pour #{@gold_standard_identity.first_name} #{@gold_standard_identity.last_name}."
      flash[:status_color] = "success-green"

      # # These lines update today's csv
      # @gold_standard_identities = GoldStandardIdentity.where("created_at > ?", Date.today)
      # File.open("exports/registered_identities_#{session[:username]}_C#{session[:computer_number]}_#{session[:location]}_#{Date.today}.csv",
      #  'w') { |file| file.write(@gold_standard_identities.as_csv) }
      redirect_to gold_standard_identity_url(@gold_standard_identity)
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
    :stop_number, :arrival_date, :mode_of_transport)
  end

end