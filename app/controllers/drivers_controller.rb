class DriversController < ApplicationController
    before_action :require_logged_in
    def new
        new_driver
    end

    def create
        @driver = Driver.new(driver_params)
        # raise params.inspect
        if @driver.save
            redirect_to team_driver_path(@driver.team, @driver)
        else
            render :new
        end
    end

    def index
        all_drivers
        current_user.teams.each do |team|
            @team = team
        end
    end

    def show
        # binding.pry
        if params[:team_id]
            @team = Team.find_by(id: params[:team_id])
            @driver = @team.drivers.find_by(id: params[:id])
            if @driver.nil?
                redirect_to team_drivers_path(current_user)
            end
        else
        find_driver
        end
    end

    def edit
        binding.pry
        if current_user.team_ids.to_s.include?(params[:team_id])
            team = Team.find_by(id: params[:team_id])
            if team.nil?
                redirect_to teams_path, alert: "Team not found"
            else
                @driver = Driver.find_by(id: params[:id])
                redirect_to team_drivers_path(current_user.id), alert: "car not found" if @car.nil?
            end
        else
            find_driver
        end
    end

    def update
        find_driver
        
        if current_user.team_ids.to_s.include?(params[:driver][:team_id])
        @driver.update(driver_params)
        if @driver.save
            redirect_to team_driver_path(@driver)
            
        end
        else 
            binding.pry
            redirect_to edit_team_driver_path(current_user)#, flash: "Not Your Device"
        end
    end

    def destroy
        find_driver
        @driver.destroy
        flash[:notice] = "driver deleted."
        redirect_to team_driver_path
    end

    private

        def driver_params
            params.require(:driver).permit(:name, :nationality, :permanent_number, :team_id)
        end

        def all_drivers
            @drivers = Driver.all
        end

        def new_driver
            @driver = Driver.new
        end

        def find_driver
            @driver = Driver.find(params[:id])
        end
end
