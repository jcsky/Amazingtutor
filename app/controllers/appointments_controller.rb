class AppointmentsController < ApplicationController

  #user預約時 appointment 要包含teacher_id 和 user_id
  before_action :set_appointment_params, :only => [:create]

  def index
    @appointments=Appointment.find_by_user_id(User.first)
  end

  def show
    @appointment = Appointment.find(params[:id])

    @evaluationsArray = Evaluation.where(appointment_id: @appointment, user_id: current_user.id, teacher_id: @appointment.teacher_id)

    @raty = @evaluationsArray.first.rating
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
end
