module CarsHelper
    def driver_select(car, path)
        select_tag "car[driver_id]", options_from_collection_for_select(Driver.all, :id, :name), include_blank: true
    end

    def car_team_select(car, path)
        select_tag "car[team_id]", options_from_collection_for_select(Team.all, :id, :name), include_blank: true
    end
end
