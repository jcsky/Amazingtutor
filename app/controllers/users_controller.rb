class UsersController < ApplicationController
  before_action :find_user
  before_action :user_authority
  before_action :set_appointment_new_params, only: [:new]

  def classes
    @appointments = @user.appointments
    @teacher = Teacher.where(:id => Teacher.all.first).first
  end

  def remark
  end

  def changepassword
  end

  def mytutor

    @teachers = Teacher.where(id: current_user.user_available_sections.pluck(:teacher_id).uniq)
    if params[:selected]
      @teacher = Teacher.find(params[:tid].to_i)
      @selected = params[:selected].to_date
      @type = params[:type].to_i
      @times = @teacher.find_available_times(@selected,@type)
    else
      @times = []
    end

    respond_to do |format|
      format.html
      format.js
    end

  end

  def profile
  end

  def create

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
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:image, :alternate_email,:username,:first_name,:last_name,:birthday,
                                 :time_zone,:tongue,:location,:currency,:born_form,:live_in,:gender)
  end

  def set_appointment_new_params
    params.permit(:teacher_id)
  end
end
