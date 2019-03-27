class LessonsController < ApplicationController
    before_action :require_login

    def create
        lesson = Lesson.new(user_id: current_user.id, category_id: params[:category_id], result: true)

        if lesson.save
            Activity.create(user_id: current_user.id, action_id: lesson.id, action_type: "Lesson")
            redirect_to new_lesson_answer_path(lesson)
        else
            redirect_to categories_path
        end
    end

    def show
        @lesson = Lesson.find(params[:id])
    end

    private
    def require_login
      unless current_user
        flash[:notice] = "Please log in."
        redirect_to root_url
      end
    end

end
