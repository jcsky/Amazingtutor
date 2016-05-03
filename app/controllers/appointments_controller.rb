class AppointmentsController < ApplicationController
  before_action :set_appointment_params, :only => [:create]

  def index
    current_user = User.first
    @appointments = current_user.appointments

  end

  def show
    @appointment = Appointment.find(params[:id])

    @evalutions = Evalution.where(appointment_id: @appointment)

    if @evalutions.blank?
      @raty = 0
    else
      @raty = @evalutions.average(:rating).round(2).to_f
    end
  end

  def create
    appointment = Appointment.new(set_appointment_params)
    current_user = User.first
    appointment.student_id = current_user.id
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
        Appointment.create_appointment(appointment.start,
                                       appointment.end,
                                       appointment.teacher_id,
                                       current_user)
        # 扣掉預約後的堂數
        UserAvailableSection.update_credit(credit, calc_section, 'less')
      end
    end
    redirect_to appointments_path
  end

  private
  def set_appointment_params
    params.require(:appointment).permit(:teacher_id, :book_section)
  end
end
