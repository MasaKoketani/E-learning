class Admins::CategoriesController < ApplicationController
  before_action :require_login
  before_action :not_admin_user

  def index
    @categories = Category.page(params[:page]).per(10)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Succsesful create new category!"
      redirect_to admins_categories_path
    else
      render "new"
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(category_params)
      redirect_to admins_categories_path
    else
      render "edit"
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category deleted"
    redirect_to admins_categories_path
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

    def category_params
      params.require(:category).permit(:title, :content)
    end

end
