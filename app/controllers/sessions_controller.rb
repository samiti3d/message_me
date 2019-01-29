class SessionsController < ApplicationController

    before_action :logged_in_redirect, only: [:new, :create]

    def new
    end

    def create
        # byebug
        user = User.find_by(username: params[:session][:username])
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "ลงชื่อเข้าใช้สำเร็จ"
            redirect_to root_path
        else
            flash.now[:error] = "การลงชื่อเข้าใช้ผิดพลาดบางอย่าง"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "ออกจากระบบเรียบร้อยแล้ว"
        redirect_to login_path
    end

    private

    def logged_in_redirect
        if logged_in?
            flash[:error] = "คุณลงชื่ออยู่ในระบบอยู่แล้ว"
            redirect_to root_path
        end
    end
end
