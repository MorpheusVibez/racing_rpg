class UsersController < ApplicationController
    before_action :require_logged_in, only: [:show, :edit, :update]
    def index
        all_users
    end
    
    def new
       new_user
       
    end

    def create
        # raise params.inspect
        @user = User.new(user_params)
        if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        # binding.pry
        find_user
    end

    def edit
        find_user
        # @user.devices.build
        # raise params.inspect
    end

    def update
        find_user
        if @user.update_attributes(user_params)
            # build_device
            binding.pry
          # Handle a successful update.
          redirect_to user_path(@user)
        else
          render :edit
        end
    end

    # def login
    #     all_users
    #     new_user
    # end

    private

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :name, :location, teams_attributes: [:name, :nationality])
    end

    def all_users
        @users = User.all
    end

    def new_user
        @user = User.new
    end

    def build_team
       team = @user.teams.build(params[:user][:teams_attributes]['0'].permit!)
       team.user_id = @user.id
    end

    def find_user
        @user = User.find(params[:id])
    end
end
