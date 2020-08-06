class SessionsController < ApplicationController
    def new
    end

    def create
      
        user = User.find_by(username: params[:username])
        # raise params.inspect
        user_authenticate = user.try(:authenticate, params[:password])

        if user_authenticate
          session[:user_id] = user_authenticate.id
          redirect_to user_url(user)
        else
          redirect_to new_user_path
        end
        
       
    end
    
      def destroy
        logout
      end
end
