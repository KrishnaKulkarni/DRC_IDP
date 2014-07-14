class GoldStandardMatchesController < ApplicationController
  def create
    xx.each do |match|
      GoldStandardMatch.create(match)
    end
    n = 2
    flash[:status] = "You have successfully submitted #{n} matches."
    flash[:status_color] = "success-green"
    redirect_to find_matches_url
  end
end