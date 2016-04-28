class AppointmentsController < ApplicationController
  def show
    @appointment = Appointment.find(params[:id])

    @evalutions = Evalution.where(appointment_id: @appointment)

    if @evalutions.blank?
      @raty = 0
    else
      @raty = @evalutions.average(:rating).round(2).to_f
    end
  end
end
