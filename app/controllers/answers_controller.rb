class AnswersController < ApplicationController
  before_action :require_login

  def new
    @lesson = Lesson.find(params[:lesson_id])
    @answer = @lesson.answers.build
  end

  def create
    @lesson = Lesson.find(params[:lesson_id])
    @category = Category.find(@lesson.category_id)
    @answer = @lesson.answers.build(answer_params)

    if @answer.save
      flash[:notice] = "Successfully saved your answer"
      if (@category.questions - @lesson.questions).empty?
        redirect_to lesson_path(@lesson)
      else
        redirect_to new_lesson_answer_path(lesson_id: @lesson.id)
      end
    end
  end

  private
  def require_login
    unless current_user
      flash[:notice] = "Please log in."
      redirect_to root_url
    end
  end

  def answer_params
    params.require(:answer).permit(:question_id, :choice_id, :lesson_id)
  end

end

