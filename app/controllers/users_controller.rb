class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def index
    @users = User.search(params[:search]).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Succsesful sign-up!"
      redirect_to feed_path
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @activities = Activity.where(user_id: @user.id).order(updated_at: "desc")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to feed_path
    else
      render "edit"
    end
  end

  def feed
    @user = User.find(current_user.id)
    users = Relationship.where(follower_id: @user.id).collect { |n| n.followed_id}
    users << @user
    @activities = Activity.where(user_id: users).order(updated_at: "desc")
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

    def admin_user
      if current_user.admin
        redirect_to admins_users_path
      end
    end
end
