class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def current_user
        if !@current_user 
            @current_user = nil
        else
            @current_user ||= User.find(session[:user_id]) if session[:user_id]
        end

    end 

    def logged_in?
        !!current_user
    end

    def require_user
        if !logged_in?
            # flash[:error] = "กรุณาเข้าสู่ระบบก่อน"
            redirect_to login_path
        end
    end

end
