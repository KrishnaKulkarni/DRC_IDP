class GoldStandardIdentitiesController < ApplicationController
  include MatchAlgorithm

  before_filter :ensure_signed_in!

  def find_matches
    @gold_standard_identity = GoldStandardIdentity.new
    render :find_matches
  end

  def search_form
    @gold_standard_identity = GoldStandardIdentity.new
    render "_search_form", :layout => false
  end

  def search_fields
    @gold_standard_identity = GoldStandardIdentity.new
    render "_search_fields", :layout => false
  end

  def new
    @gold_standard_identity = GoldStandardIdentity.new
    render :new
  end

  def create
    handle_age!

    @gold_standard_identity = GoldStandardIdentity.new(gold_standard_identity_params)
    @gold_standard_identity.recorded_by = session[:username]
    @gold_standard_identity.recorded_in_village = session[:location]
    if @gold_standard_identity.save
      flash[:status] = "Enregistrement reussi pour #{@gold_standard_identity.first_name} #{@gold_standard_identity.last_name}."
      flash[:status_color] = "success-green"

      # These lines update today's csv
      @gold_standard_identities = GoldStandardIdentity.where("created_at > ?", Date.today)
      File.open("exports/registered_identities_#{session[:username]}_C#{session[:computer_number]}_#{Date.today}.csv",
       'w') { |file| file.write(@gold_standard_identities.as_csv) }
      redirect_to gold_standard_identity_url(@gold_standard_identity)
    else
      flash.now[:status] = "Erreur d'enregistrement"
      flash.now[:status_color] = "failure-red"
      render :new
    end
  end

  def index
    @gold_standard_identities = GoldStandardIdentity.all
    send_data @gold_standard_identities.as_csv
  end

  def show
    render :show
  end

  def test_page
    @gold_standard_identity = GoldStandardIdentity.new
    render '_search_form'
  end

  def match_results
    candidates = IomIdentity.all
    matches = generate_matches_list(gold_standard_identity_params, candidates)
    render json: matches
  end

  private
  def handle_age!
    @age = params[:gold_standard_identity]["age"]
    @year_of_birth = params[:gold_standard_identity]["date_of_birth"]
    if @year_of_birth.present?
      params[:gold_standard_identity]["date_of_birth"] += "-01-01"
    elsif @age.present?
      year = (2014 - @age.to_i).to_s
      params[:gold_standard_identity]["date_of_birth"] = year + "-01-01"
    end
  end

  def gold_standard_identity_params
    params.require(:gold_standard_identity).permit(
    :first_name, :last_name, :alternate_name, :nick_name, :sex, :date_of_birth,
    :other_first_name, :other_last_name, :other_alternate_name, :identity_card,
    :village_id, :group_id, :collective_id, :territory_id, :province_id,
    :recorded_in_village_id, :recorded_by, :alternate_village, :alternate_village_status, :village_of_origin,
    :head_of_household_status, :head_of_household_first_name, :head_of_household_last_name,
    :head_of_household_alternate_name, :relation_to_head_of_household,
    :household_size, :arrival_date, :arrival_from_village)
  end
end
