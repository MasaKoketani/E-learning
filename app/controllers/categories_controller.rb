class CategoriesController < ApplicationController
  before_action :require_login

  def index
    if params[:status] == "Learned"
      @categories = Category.joins(:lessons).where(lessons: {result: true})
    elsif params[:status] == "UnLearned"
      @categories = Category.includes(:lessons).where(lessons: {category_id: nil})
    else
      @categories = Category.all
    end
    @lesson = Lesson.new
    # abort
  end

  private
  def require_login
    unless current_user
      flash[:notice] = "Please log in."
      redirect_to root_url
    end
  end

end
