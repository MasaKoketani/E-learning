class Admins::QuestionsController < ApplicationController
    before_action :require_login
  before_action :not_admin_user

  def index
    @category = Category.find(params[:category_id])
    @questions = @category.questions.includes(:choices)
  end

  def new
    @category = Category.find(params[:category_id]) 
    @question = @category.questions.build
    3.times do
        @question.choices.build
    end
  end

  def create
    @category = Category.find(params[:category_id]) 
    @question = @category.questions.build(question_params)

    if @question.save
        flash[:notice] = "Create new Questions!"
        redirect_to admins_category_questions_path(category_id: @category)
    else
        render "new"
    end
  end

  def show
  end

  def edit
    @category = Category.find(params[:category_id]) 
    @question = Question.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @question = Question.find(params[:id])

    if @question.update_attributes(question_params)
      flash[:notice] = "Edit Questions!"
      redirect_to admins_category_questions_path(category_id: @category)
    else
      render "edit"
    end
  end

  def destroy
    question = Question.find(params[:id])
    Choice.where(question_id: question.id).delete_all
    question.destroy
    flash[:success] = "Question deleted"
    redirect_to admins_category_questions_path
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

    def question_params
      params.require(:question).permit(:content, choices_attributes: [:content, :correct, :id])
    end

end
