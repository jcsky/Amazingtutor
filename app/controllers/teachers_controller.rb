class TeachersController < ApplicationController
  before_action :get_teacher, except: :update

  # 只有user裡面的author得值要等於teacher才可以進來 但大家都有第一次可能進來沒有teacher
  # 所以全部要before_action先建好teacher 如果已經有了就用已經有的

  def introduce
    @languages = @teacher.languages
    # @teacher = Current
  end

  def price
  end

  def gathering
    @gathering = @teacher.gathering_way
  end

  def education
    @education = @teacher.education
  end

  def youtube
    @youtube = @teacher.youtube
  end

  def update
    @teacher = current_user.teacher
    @teacher.update(teacher_params)
    if @teacher.save
     redirect_to :back
     flash[:alert]= "Save success"
   else
      flash[:alert]= "Save fail"
   end
  end

  private

  def get_teacher
    @teacher = if current_user.teacher
                 current_user.teacher
               else
                 current_user.create_teacher
               end
  end

  def teacher_params
    params.require(:teacher).permit(:user_id, :youtube, :introduction, :trial_fee,
                                    :one_fee, :five_fee, :ten_fee, :gathering_way, languages_attributes: [:language, :_destroy, :id])
  end
end
