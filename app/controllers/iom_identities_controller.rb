class IomIdentitiesController < ApplicationController
	def importing_page
    render :importing_page
  end

  def import
    csv = params[:file].path
    model_class = params[:model_class].constantize

    if Importers::Importer.import_file!(csv, model_class, true)
      flash[:status] = "#{model_class} CSV successfully imported!"
      flash[:status_color] = "success-green"
    else
      flash[:status] = "Import failure. At least one record could not be created. Check the import logs."
      flash[:status_color] = "failure-red"
    end

    redirect_to iom_importing_page_url
  end
end