class GoldStandardMatchesController < ApplicationController
  def create
    # gold_id =  params["gold_standard_identities"].keys.firstf
    n = 0
    params["gold_standard_matches"].keys.each do |iom_id|
      gsm = GoldStandardMatch.new(gold_standard_identity_id: session["last_registered_identity_id"], iom_identity_id: iom_id)
      if gsm.save
        n += 1
      end
    end

    File.open("exports/registered_matches_#{session[:username]}_C#{session[:computer_number]}_#{session[:location]}_#{Date.today}.csv",
       'w') { |file| file.write(GoldStandardMatch.as_csv) }

    flash[:status] = "You have successfully submitted #{n} matches."
    flash[:status_color] = "success-green"
    redirect_to find_matches_url
  end
end