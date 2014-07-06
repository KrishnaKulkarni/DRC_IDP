class GoldStandardIdentitiesController < ApplicationController
  def find_matches
    @gold_standard_identity = GoldStandardIdentity.new
    render :find_matches
  end
  
  def search_form
    @gold_standard_identity = GoldStandardIdentity.new
    render "_search_form", :layout => false
  end
  
  def new
    @gold_standard_identity = GoldStandardIdentity.new
    render :new
  end
  
  def create
    @gold_standard_identity = GoldStandardIdentity.new(gold_standard_identity_params)

    if @gold_standard_identity.save
      flash.now[:new_record_status] = "Your registration of #{@gold_standard_identity.first_name} #{@gold_standard_identity.last_name} was successful."
      flash.now[:status_color] = "success-green"
      @gold_standard_identity = GoldStandardIdentity.new
    else
      flash.now[:new_record_status] = "There was an error with your entry."
      flash.now[:status_color] = "failure-red"
    end

    render :new
  end

  private
  def gold_standard_identity_params
    params.require(:gold_standard_identity).permit(
    :first_name, :last_name, :alternate_name, :sex, :date_of_birth, 
    :village_id, :group_id, :collective_id, :territory_id, :province_id,
    :recorded_in_village_id, :recorded_by, :alternate_village, :village_of_origin,
    :head_of_household_first_name, :head_of_household_last_name, :relation_to_head_of_household,
    :household_size, :arrival_date, :arrival_from_village)
  end
end
