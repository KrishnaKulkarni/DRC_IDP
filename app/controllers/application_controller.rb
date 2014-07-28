class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def ensure_signed_in!
  	unless session[:signed_in]
	    flash[:status] = "Vous devez vous connecter d'abord"
	    redirect_to new_session_url unless session[:signed_in]
   	end
  end

  def clear_identity_cache
    session[:last_registered_identity_id] = nil
  end

  def store_identity_cache(id)
    session[:last_registered_identity_id] =  id
  end
end
