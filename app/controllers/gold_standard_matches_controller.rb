class GoldStandardMatchesController < ApplicationController
  def create
    # gold_id =  params["gold_standard_identities"].keys.firstf
    n = 0
    params["gold_standard_matches"].keys.each do |iom_id|
      GoldStandardMatch.create(gold_standard_identity_id: session["last_registered_identity_id"], iom_identity_id: iom_id)
      n += 1
    end
    clear_identity_cache

    flash[:status] = "You have successfully submitted #{n} matches."
    flash[:status_color] = "success-green"
    redirect_to find_matches_url
  end
end