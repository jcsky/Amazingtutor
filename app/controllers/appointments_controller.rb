class AppointmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  # user預約時 appointment 要包含teacher_id 和 user_id
  before_action :set_appointment_params, only: [:create]
  before_action :set_appointment_new_params, only: [:new]
  before_action :find_appointment, only: [:show]
  before_action :user_authority, only: [:show]

  def index
    @appointments = Appointment.find_by_user_id(User.first)
  end

  def show

    @user = current_user

    @evaluationsArray = Evaluation.where(evaluatable_type: 'User',
                                         evaluatable_id: current_user, appointment_id: @appointment)

    @raty = if @evaluationsArray.blank?
              0
            else
              @evaluationsArray.first.rating
            end

    @evaluationsArrayTa = Evaluation.where(evaluatable_type: 'Teacher',
                                           evaluatable_id: current_user.teacher, appointment_id: @appointment)

    @commentTa = @evaluationsArrayTa.first.try(:comment)

    if @appointment.appointment_url.blank?
      charset = ""
      url = ""
      charset = (0...9).map { ('a'..'z').to_a[ rand(26)] }.join
      url =  "https://talkgadget.google.com/hangouts/_/n"+charset+"aelp4l25okzw3tw4e?hl=en-US"
      @appointment.appointment_url = url
      @appointment.save
    end
  end

  def new
    @teacher = Teacher.find_by_id(set_appointment_new_params[:teacher_id])
    if @teacher.nil?
      flash[:alert] = 'this id is a wrong teacher_id'
      redirect_to teachers_path
    end
    unless current_user.nil?
      @user_available_sections = current_user.user_available_sections.find_by_teacher_id(set_appointment_new_params[:teacher_id])
    end
  end

  def create
    @teacher = Teacher.find(set_appointment_params[:teacher_id])
    appointment = Appointment.new(set_appointment_params)
    appointment.user = current_user
    appointment.section = (appointment.end.in_time_zone - appointment.start.in_time_zone) / 30.minute
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
      calc_section = (appointment.end.in_time_zone - appointment.start.in_time_zone) / 30.minute
      if avaiable_section_check && !appointment_check && credit[:available_section] >= calc_section.to_i
        # 設定預約課程
        # Appointment.create_appointment(appointment.start,
        #                                appointment.end,
        #                                appointment.teacher_id,
        #                                current_user)
        appointment.save
        # 扣掉預約後的堂數

        if appointment.appointment_url.blank?
          charset = ""
          url = ""
          charset = (0...9).map { ('a'..'z').to_a[ rand(26)] }.join
          url =  "https://talkgadget.google.com/hangouts/_/n"+charset+"aelp4l25okzw3tw4e?hl=en-US"
          appointment.appointment_url = url
          appointment.save
        end
        UserAvailableSection.update_credit(credit, appointment.section, 'less')
        if calc_section == 1
          credit.trailed = nil
          credit.save!
        end
      end
    end
    UserMailer.notify_teacher_new_appointment(current_user, @teacher.user, appointment.start.in_time_zone).deliver_now
    UserMailer.notify_student_new_appointment(current_user, @teacher.user, appointment.start.in_time_zone).deliver_now
  end

  def destroy
    ActiveRecord::Base.transaction do
      appointment = current_user.appointments.find_by_id(destroy_appointment_params[:id])
      appointment.check_and_destroy!
      users_available_section = current_user.user_available_sections.first
      UserAvailableSection.update_credit(users_available_section, appointment.section, 'plus')
      users_available_section.trailed = false if appointment.section == 1
    end
    redirect_to :back
  end

  private

  def find_appointment
    @appointment = Appointment.find(params[:id])
  end

  def set_appointment_params
    start_time, end_time = params[:time].split('-')
    appointment_params = {}
    appointment_params[:teacher_id] = params[:tid].to_i
    appointment_params[:start]      = (params[:selected] + ' ' + start_time).to_datetime.in_time_zone
    appointment_params[:start] += -appointment_params[:start].utc_offset
    appointment_params[:end]        = (params[:selected] + ' ' + end_time).to_datetime.in_time_zone
    appointment_params[:end] += -appointment_params[:end].utc_offset
    appointment_params
  end

  def set_appointment_new_params
    params.permit(:teacher_id)
  end

  def destroy_appointment_params
    params.permit(:id)
  end

  def user_authority
    @appointment = Appointment.find(params[:id])
    if current_user.nil? || ( current_user.id != @appointment.user_id && current_user.try(:teacher).id != @appointment.teacher_id )
      redirect_to root_path
    end
  end

end
