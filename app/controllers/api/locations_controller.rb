class Api::LocationsController < ApplicationController
  def collections
    location_class = params[:location_type].singularize.capitalize.constantize
    render json: location_class.all
  end
end