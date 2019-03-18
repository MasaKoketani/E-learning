class Admins::UsersController < ApplicationController
    before_action :require_login
    before_action :not_admin_user
    def index
        @users = User.page(params[:page]).per(10)
    end

    def update
        @user = User.find(params[:id])
        if @user.admin
          @user.update(admin: false)
        else
          @user.update(admin: true)
        end

        redirect_to admins_users_path
    end


    private
    def require_login
      unless current_user
        flash[:notice] = "Please log in."
        redirect_to root_url
      end
    end

    def not_admin_user
      unless current_user.admin
        flash[:notice] = "You don't have Authority."
        redirect_to users_path
      end
    end
end
