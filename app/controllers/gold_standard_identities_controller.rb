class GoldStandardIdentitiesController < ApplicationController
  def find_matches
    @gold_standard_identity = GoldStandardIdentity.new
    render :find_matches
  end
end
