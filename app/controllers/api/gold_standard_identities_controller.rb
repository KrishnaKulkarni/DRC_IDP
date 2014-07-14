class Api::GoldStandardIdentitiesController < ApplicationController

  def create
    @gold_standard_identity = GoldStandardIdentity.new(gold_standard_identity_params)
    @gold_standard_identity.recorded_by = session[:username]
    if @gold_standard_identity.save
      # @gold_standard_identities = GoldStandardIdentity.where("created_at > ?", Date.today)
      # File.open("exports/registered_identities_#{session[:username]}_C#{session[:computer_number]}_#{Date.today}.csv",
      #  'w') { |file| file.write(@gold_standard_identities.as_csv) }

      render json: @gold_standard_identity
    else
      render json: @gold_standard_identity.errors
    end
  end

  def show
    @gold_standard_identity = GoldStandardIdentity.find(params[:id])
    render json: @gold_standard_identity
  end

  def index
    @gold_standard_identities = GoldStandardIdentity.all

    render json: @gold_standard_identities
  end

  private
  def gold_standard_identity_params
    params.require(:gold_standard_identity).permit(
    :first_name, :last_name, :alternate_name, :sex, :date_of_birth,
    :village_id, :group_id, :collective_id, :territory_id, :province_id,
    :recorded_in_village_id, :recorded_by)
  end
end
