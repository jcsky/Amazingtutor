class AppointmentsController < ApplicationController

  #user預約時 appointment 要包含teacher_id 和 user_id
  before_action :set_appointment_params, :only => [:create]
  before_action :user_authority, :only => [:show]

  def index
    @appointments=Appointment.find_by_user_id(User.first)
  end

  def show
    @appointment = Appointment.find(params[:id])
    @user= current_user

    @evaluationsArray = Evaluation.where(evaluatable_type: "User",
                                         evaluatable_id: current_user, appointment_id: @appointment)

    if @evaluationsArray.blank?
      @raty = 0
    else
      @raty = @evaluationsArray.first.rating
    end

    @evaluationsArrayTa = Evaluation.where(evaluatable_type: "Teacher",
                                           evaluatable_id: current_user.teacher, appointment_id: @appointment)

    @commentTa = @evaluationsArrayTa.first.try(:comment)

  end

  def create
    appointment = Appointment.new(set_appointment_params)
    current_user = User.first
    appointment.user = current_user
    appointment.section = (appointment.end.to_time - appointment.start.to_time) / 30.minute
    # appointment.student_id = 1
    ActiveRecord::Base.transaction do
      # 查詢該時段是不是可被預約的時間
      avaiable_section_check = AvailableSection.lock.avaiable_section_check(appointment.start,
                                                                            appointment.end,
                                                                            appointment.teacher_id)
      # 查詢該時段是不是已經被預約
      appointment_check = Appointment.appointment_check(appointment.start,
                                                        appointment.end,
                                                        appointment.teacher_id)
      # 減掉user_avaiable_section的數值
      credit = UserAvailableSection.lock.query_credit(appointment.teacher_id, current_user)
      calc_section = (appointment.end.to_time - appointment.start.to_time) / 30.minute
      if avaiable_section_check and !appointment_check and credit[:available_section] >= calc_section.to_i
        # 設定預約課程
        # Appointment.create_appointment(appointment.start,
        #                                appointment.end,
        #                                appointment.teacher_id,
        #                                current_user)
        appointment.save
        # 扣掉預約後的堂數
        UserAvailableSection.update_credit(credit, appointment.section, 'less')
      end
    end
    redirect_to appointments_path
  end

  private

  def set_appointment_params
    params.require(:appointment).permit(:teacher_id, :book_section)
  end

  def user_authority
    @appointment = Appointment.find(params[:id])
    if current_user == nil || (@appointment.user.id != @appointment.user_id && @appointment.teacher.id != @appointment.teacher_id)
      redirect_to root_path
    end
  end

end
