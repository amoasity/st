class ApplicationController < ActionController::Base

    before_action :current_user
    before_action :current_team

    def current_user
        @current_user = User.find_by(id: session[:user_id])
    end 

    def current_team
        @current_team = Team.find_by(id: session[:team_id])
    end 

    def have_to_login
        if @current_user == nil
            flash[:notice] = "have to login"
            redirect_to("/")
        end
    end 

    def already_login
        if @current_user
            flash[:notice] = "already_login"
            redirect_to("/match")
        end
    end 

    def have_to_create_team
        if @current_team == nil
            flash[:notice] = "チームに所属していません"
            redirect_to team_create_path
        end
    end

    def teams_of_current_user
        if @current_user
            teamusers = TeamUser.where(user_id: @current_user.id)
            teams_id_of_current_user = teamusers.pluck(:team_id)
            @teams_of_current_user = Team.where(id: teams_id_of_current_user)
        end
    end

    def teams_of_current_user_apart_from_current_team
        if @current_user && @current_team
            teamusers = TeamUser.where(user_id: @current_user.id).where("team_id != ?", @current_team.id)
            teams_id_of_current_user_apart_from_current_team = teamusers.pluck(:team_id)
            @teams_of_current_user_apart_from_current_team = Team.where(id: teams_id_of_current_user_apart_from_current_team)
        end
    end
    
    def date_adj
        @date_hash = {
            "fir" => 1, "sec" => 2, "thi" => 3, "fou" => 4, "fif" => 5, "six" => 6, "sev" => 7,
            "eig" => 8, "nin" => 9, "ten" => 10, "ele" => 11, "twe" => 12, "ten_thi" => 13, "ten_fou" => 14,
            "ten_fif" => 15, "ten_six" => 16, "ten_sev" => 17, "ten_eig" => 18, "ten_nin" => 19, "twentieth" => 20, "twe_fir" => 21,
            "twe_sec" => 22, "twe_thi" => 23, "twe_fou" => 24, "twe_fif" => 25, "twe_six" => 26, "twe_sev" => 27, "twe_eig" => 28,
            "twe_nin" => 29, "thirtieth" => 30, "thi_fir" => 31,
          }
    end

    def variable
        @tomorrow = Date.today.tomorrow
        @this_month = Date.today.month
        @end_of_month = Date.today.end_of_month
        @end_of_next_month = Date.today.next_month.end_of_month
        @range1 = @tomorrow.mday..@end_of_month.mday
        @range2 = 1..@end_of_next_month.mday
        @day_of_week = ["日", "月", "火", "水", "木", "金", "土"]
    end

end
