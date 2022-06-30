module ApplicationHelper
    def current_user_status
        @current_user.status ? "online":nil
    end
end