class WelcomeController < ApplicationController
  def index
    if params[:lan_id].nil?
      @teacher = Teacher.all
      byebug
    elsif params[:lan_id]
      @lan_id = params[:lan_id]
      @teacher = Teacher.includes(:teacher_languageships).where(teacher_languageships: { language_id: @lan_id }).order('id DESC')

    end
    render layout: 'welcome'
  end

  def apply_teacher
  end

  def sorting
  end

  def scholarship
  end
end
