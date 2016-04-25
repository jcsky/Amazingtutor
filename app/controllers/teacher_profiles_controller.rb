class TeacherProfilesController < ApplicationController

  def introduce
    if current_user.teacher
      @introduce = current_user.teacher.introduce
    else
      redirect_to root_path
    end
  end

  def price
  end

  def gethering
  end

  def education
  end

  def youtube
  end

  def update
  end

  private


end
