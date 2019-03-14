class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def index
    if !current_user
      render "static_pages/home"
    end

    @users = User.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Succsesful sign-up!"
      redirect_to root_url
    else
      render "new"
    end
  end

  def show

    if !current_user
      render "static_pages/home"
    end

    @user = User.find(params[:id])
  end


  private
    def require_login
      unless current_user
        flash[:notice] = "Please log in."
        redirect_to root_url
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :picture, :password)
    end
end
