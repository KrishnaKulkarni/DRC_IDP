class StaticPagesController < ApplicationController
  include DataProcessing

  def process_data
    @idps = TestIdp.all
    @reconciled_matches = ReconciledMatch.all
    @unreconciled_matches = UnreconciledMatch.all
    render :process_data
  end
  
  def read_csv
    @csv, @filename = params[:file], params[:filename]
    process_csv!
    
    redirect_to root_url, notice: "CSV Imported"
  end
  
  # def enter_record
  #   @test_idp = TestIdp.new
  #   render :enter_record
  # end
  #
  # def create_record
  #   @first_name = params["idp"]["first_name"]
  #
  #   TestIdp.create!(idp_params)
  #   render :enter_record
  # end
  
  # def idp_params
  #   params.require(:idp).permit(:first_name, :last_name)
  # end

end
