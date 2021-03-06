class SessionsController < ApplicationController
    def new
      if current_user
        render "users/feed"
      end
    end

    def create
        user = User.find_by(email: params[:session][:email])

        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = "Hurray! Successfully logged in!"
            redirect_to feed_path
        else
            flash[:danger] = "Invalid Credentials"
            render "new"
        end
    end

    def destroy

      if !current_user
        render "static_pages/home"
      end

        session.delete(:user_id)
        flash[:notice] = "Successfully logged out."

        redirect_to root_url
    end
end
