class IomIdentitiesController < ApplicationController
	def importing_page
    render :importing_page
  end

  def import
    csv = params[:file]
    if IomIdentity.import!(csv)
      flash[:status] = "CSV successfully imported!"
      flash[:status_color] = "success-green"
    else
      flash[:status] = "Import failure. At least one idenity could not be created."
      flash[:status_color] = "failure-red"
    end

    redirect_to iom_importing_page_url
  end
end