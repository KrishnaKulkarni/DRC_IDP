class Api::IomIdentitiesController < ApplicationController
  
  def create
    @iom_identity = IomIdentity.new(iom_identity_params)
    if @iom_identity.save
      render json: @iom_identity
    else
      render json: @iom_identity.errors
    end
  end
  
  
  def destroy
    @iom_identity = IomIdentity.find(params[:id])
    render json: @iom_identity.destroy!
  end
  
  def show
    @iom_identity = IomIdentity.find(params[:id])
    render json: @iom_identity
  end
  
  def index
    @iom_identities = GoldStandardIdentity.find(params[:gold_standard_identity_id]).iom_identity_matches
    
    render json: @iom_identities
  end
  
  def temp_index
    @iom_identities = IomIdentity.all
    render json: @iom_identities
  end
  
  def update
    @iom_identity = IomIdentity.find(params[:id])
    if @iom_identity.update_attributes(iom_identity_params)
      render json: @iom_identity
    else
      render :json => @iom_identity.errors, :status => :unprocessable_entity
    end
  end
  
  private
  def iom_identity_params
    params.require(:iom_identity).permit(
    :first_name, :last_name, :alternate_name, :sex, :date_of_birth, 
    :village_id, :group_id, :collective_id, :territory_id, :province_id,
    :recorded_in_village_id, :recorded_by, :alternate_village, :village_of_origin)
  end
  
end