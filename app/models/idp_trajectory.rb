class  IdpTrajectory < ActiveRecord::Base
	belongs_to :identity, inverse_of: :idp_trajectories
end
