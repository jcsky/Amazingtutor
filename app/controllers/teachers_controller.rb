class TeachersController < ApplicationController

  def introduce
    current_user.create_teacher.second_tongues.create
    if current_user.teacher
      @teacher = current_user.teacher
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
    @teacher = current_user.teacher
    @teacher.update(teacher_params)
    if @teacher.save
      redirect_to root_path
    else
      render :introduce
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:user_id,:youtube ,:introduction,:trial_fee,:one_fee,:five_fee,:ten_fee,:gathering_way,second_tongues_attributes:[:language])
  end
end
