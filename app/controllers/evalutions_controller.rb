class EvalutionsController < ApplicationController

  before_action :set_appointment

  def index
    @evalutions = Evalution.all
  end

  def new
    @evalution = Evalution.new
  end

  def create
    @evalution = Evalution.new( :rating => params[:rating] )
    @evalution.appointment = @appointment
    @evalution.save
    @evalutions = Evalution.where(appointment_id: @appointment)

    if @evalutions.blank?
      @raty = 0
    else
      @raty = @evalutions.average(:rating).round(2).to_f
    end

    respond_to do |format|
      format.js
    end

  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:appointment_id])
  end

  def evalution_params
    params.require(:evalution).permit(:comment, :rating)
  end

end
