class WelcomeController < ApplicationController
  def index
      @teacher = Teacher.all
      render layout: 'welcome'
  end

  def apply_teacher
  end

  def sorting
  end

  def scholarship
  end
end
