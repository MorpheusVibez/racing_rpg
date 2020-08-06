class TeamsController < ApplicationController
    before_action :require_logged_in
    def new
        new_team
    end

    def create
        @team = Team.new(team_params)
        # raise params.inspect
        if @team.save
            redirect_to team_path(@team)
        else
            render :new
        end
    end

    def index
        all_teams
    end

    def show
        # binding.pry
        if params[:user_id]
            @user = User.find_by(id: params[:user_id])
            @team = @user.teams.find_by(id: params[:id])
            if @team.nil?
                redirect_to user_teams_path(current_user)
            end
        else
        find_team
        end
    end

    def edit
        # binding.pry
        if params[:user_id] == current_user.id.to_s
            user = User.find_by(id: params[:user_id])
            if user.nil?
                redirect_to users_path, alert: "User not found"
            else
                @team = user.teams.find_by(id: params[:id])
                redirect_to user_teams_path(current_user.id), alert: "Team not found" if @team.nil?
            end
        else
            find_device
        end
    end

    def update
        find_team
        
        if params[:team][:user_id] == current_user.id.to_s
        @team.update(team_params)
        if @team.save
            redirect_to @team
            
        end
        else 
            binding.pry
            redirect_to edit_user_team_path(current_user)#, flash: "Not Your Device"
        end
    end

    def destroy
        find_team
        @team.destroy
        flash[:notice] = "team deleted."
        redirect_to teams_path
    end

    private

        def team_params
            params.require(:team).permit(:name, :nationality, :driver_id, :user_id, :car_id)
        end

        def all_teams
            @teams = Team.all
        end

        def new_team
            @team = Team.new
        end

        def find_team
            @team = Team.find(params[:id])
        end
end
