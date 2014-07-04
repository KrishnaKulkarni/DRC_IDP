class GoldStandardIdentitiesController < ApplicationController
  def find_matches
    @gold_standard_identity = GoldStandardIdentity.new
    render :find_matches
  end
  
  def create
    @gold_standard_identity = IomIdentity.new
    if @gold_standard_identity.save
      render json: @gold_standard_identity
    else
      render json: @gold_standard_identity.errors
    end
  end
  
  # def create
#     @gold_standard_identity = GoldStandardIdentity.new(gold_standard_identity_params)
#
#     if @gold_standard_identity.save
#       flash.now[:new_record_status] = "New gold_standard_identity Saved Successfully!"
#       @gold_standard_identity = GoldStandardIdentity.new
#     else
#       flash.now[:new_record_status] = "There was an error with your entry."
#     end
#
#     render :find_matches
#   end

  private
  def gold_standard_identity_params
    params.require(:gold_standard_identity).permit(
    :first_name, :last_name, :alternate_name, :sex, :date_of_birth, 
    :village_id, :group_id, :collective_id, :territory_id, :province_id,
    :recorded_in_village_id, :recorded_by)
  end
end
