module ApplicationHelper

  def current_user
#  	raise session[:remember_token].inspect
#	session[:remember_token] = nil
    @current_user ||= session[:remember_token] && User.find(session[:remember_token])
  end


  def authenticate_user
    if !current_user
      redirect_to new_sessions_path
    end
  end

end
