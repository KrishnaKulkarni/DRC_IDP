class IdpTrajectoriesController < ApplicationController
  include MatchAlgorithm

  before_filter :ensure_signed_in!
  
  def new
    @idp_trajectory = IdpTrajectory.new
    render :new
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