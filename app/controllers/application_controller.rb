class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :logged_in? 
    
    def home
    end
    
    def current_user 
      @user = (User.find_by(id: session[:user_id]) || User.new)
    end 
        
    def logged_in?
      current_user.id != nil 
          #return true if the current user's id from the db is not nil 
    end 
        
    def require_logged_in 
      if !logged_in?
        redirect_to login_path
      end 
    end
    
    def logout
      session.clear
      redirect_to '/'
    end
end
