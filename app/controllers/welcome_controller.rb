class WelcomeController < ApplicationController
  def index
    @teacher =Teacher.all
  end

  def apply_teacher
  end
end
