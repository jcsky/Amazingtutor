class AppointmentsController < ApplicationController
  #user預約時 appointment 要包含teacher_id 和 user_id
  def show
    @appointment = Appointment.find(params[:id])

    @evalution = Evalution.where(appointment_id: @appointment, user_id: current_user.id, teacher_id: @appointment.teacher_id)
    @evalutions = Evalution.where(appointment_id: @appointment)

    if @evalutions.blank?
      @raty = 0
    else
      @raty = @evalutions.average(:rating).round(2).to_f
    end
  end
end
