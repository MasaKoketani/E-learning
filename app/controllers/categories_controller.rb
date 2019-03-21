class CategoriesController < ApplicationController
  before_action :require_login

  def index
    @categories = Category.page(params[:page]).per(7)
    @lesson = Lesson.new
  end


  private
  def require_login
    unless current_user
      flash[:notice] = "Please log in."
      redirect_to root_url
    end
  end

end
