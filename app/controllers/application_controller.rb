class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   include ApplicationHelper  

   	helper_method :greeting_time

     def authenticate_user
    if !self.current_user
      redirect_to new_sessions_path
    end
  end

     def greeting_time
    if (Time.now.hour >= 05) && (Time.now.hour < 12) 
        @greeting = "Good morning, "
    elsif (Time.now.hour >= 12) && (Time.now.hour < 18)
        @greeting = "Good afternoon, "
    elsif (Time.now.hour >= 18) || (Time.now.hour < 05) 
        @greeting = "Good evening, "
    end
 end

    def AM_PM
      if (Time.now.hour >= 0) && (Time.now.hour <12)
        @am_pm = "AM"
      else
        @am_pm = "PM"
      end
    end 
  
end
