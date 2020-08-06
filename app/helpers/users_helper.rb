module UsersHelper
    def display_user(team)
        team.user.nil? ? link_to("Add User", edit_team_path(team)) : link_to(team.user, user_path(team.user))
      end
    
      def user_select(team, path)
        # binding.pry
        if team.user && path == "nested"
          hidden_field_tag "team[user_id]", team.user_id
        else
          select_tag "team[user_id]", options_from_collection_for_select(User.all, :id, :username), include_blank: true
        end
      end
end
