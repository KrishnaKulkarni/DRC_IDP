class SessionsController < ApplicationController
  def new
    @users = User.all
    render :new
  end

  def create
    if (params[:username].present? && params[:computer_number].present? && params[:location].present?)
      session[:username] = User.find(params[:username]).username
      session[:computer_number] = params[:computer_number]
      session[:location] = params[:location]
      session[:signed_in] = true

      redirect_to new_gold_standard_identity_url
    else
      flash[:status] = "Choix valide"
      redirect_to new_session_url
    end
  end

  def destroy
    session[:username], session[:computer_number] =  nil, nil
    session[:signed_in], session[:location] = nil, nil
    redirect_to new_session_url
  end

end
