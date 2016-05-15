class WelcomeController < ApplicationController
  def index

    if params[:language_id]
      @lan_id = params[:language_id]
      @teachers = Teacher.includes(:teacher_languageships).where(:teacher_languageships=>{language_id: @lan_id })
    else
      @teachers = Teacher.all
    end
  end

  def apply_teacher
  end

  def sorting
  end

  def scholarship
  end
end
