class WelcomeController < ApplicationController
  def index
    @teacher =Teacher.all
     render layout: 'welcome'
     if params[:lan_id]
      #  @sortins = 
     end
  end

  def apply_teacher
  end

  def sorting
  end
end
