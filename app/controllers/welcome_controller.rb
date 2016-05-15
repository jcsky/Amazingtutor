class WelcomeController < ApplicationController
  def index
    @teachers = Teacher.all
    if params[:language_id]
      @lan_id = params[:language_id]
      @teachers = Teacher.includes(:teacher_languageships).where(teacher_languageships: { language_id: @lan_id })
    end
  end

  def apply_teacher
  end

  def sorting
  end

  def scholarship
  end
end
