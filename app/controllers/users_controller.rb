class UsersController < ApplicationController
  before_action :find_user
  before_action :user_authority

  def classes
    @appointments = @user.appointments
    @teacher = Teacher.where(:id => Teacher.all.first).first
  end
  def remark
    @evaluations = Evaluation.where(evaluatable_type: "Teacher", evaluated_id: @user)
  end
  def changepassword
  end
  def mytutor
    @appointments = @user.appointments
  end
  def profile
  end

  def update
    @user.update(user_params)
    if params[:_remove_image] =="1"
      @user.image = nil
    end
    if @user.save
      flash[:success] = "Edit successfully"
    render 'profile'
    else
      render 'profile'
    end
  end

  private
  def user_authority
    redirect_to root_path if current_user==nil
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:image, :alternate_email,:username,:first_name,:last_name,:birthday,
                                 :time_zone,:tongue,:location,:currency,:born_form,:live_in,:gender)
  end
end
