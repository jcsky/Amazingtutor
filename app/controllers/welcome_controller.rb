class WelcomeController < ApplicationController
  def index
    @teacher =Teacher.all
     render layout: 'welcome'
    #  if params[:lan_id]
    #   v = params[:lan_id]
    #   @ = Teacher.all.language
    #  end
  end

  def apply_teacher
  end

  def sorting
  end
end
