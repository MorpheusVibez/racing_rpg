module DriversHelper
    def team_select(driver, path)
        select_tag "driver[team_id]", options_from_collection_for_select(Team.all, :id, :name), include_blank: true
    end
end
