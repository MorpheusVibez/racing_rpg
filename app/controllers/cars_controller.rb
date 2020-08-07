class CarsController < ApplicationController
    before_action :require_logged_in
    def new
        new_car
    end

    def create
        @car = Car.new(car_params)
        # raise params.inspect
        if @car.save
            redirect_to team_car_path(@car.team_id, @car)
        else
            render :new
        end
    end

    def index
        all_cars
    end

    def show
        # binding.pry
        if params[:team_id]
            @team = Team.find_by(id: params[:team_id])
            @car = @team.cars.find_by(id: params[:id])
            if @car.nil?
                redirect_to team_car_path(@team)
            end
        else
        find_car
        end
    end

    def edit
        # binding.pry
        if current_user.team_ids.to_s.include?(params[:team_id])
            team = Team.find_by(id: params[:team_id])
            if team.nil?
                redirect_to teams_path, alert: "Team not found"
            else
                @car = Car.find_by(id: params[:id])
                redirect_to team_cars_path(current_user.id), alert: "car not found" if @car.nil?
            end
        else
            find_car
        end
    end

    def update
        find_car
        binding.pry
        if current_user.team_ids.to_s.include?(params[:car][:team_id])
        @car.update(car_params)
        if @car.save
            redirect_to team_car_path(@car.team_id)
            
        end
        else 
            binding.pry
            redirect_to edit_team_car_path(current_user)#, flash: "Not Your Device"
        end
    end

    def destroy
        binding.pry
        find_car
        @car.destroy
        flash[:notice] = "car deleted."
        redirect_to team_path(current_user)
    end

    private

        def car_params
            params.require(:car).permit(:name, :team_id, :driver_id, teams_attributes: [:team_id, :driver_id])
        end

        def all_cars
            @cars = Car.all
        end

        def new_car
            @car = Car.new
        end

        def find_car
            @car = Car.find(params[:id])
        end
end
