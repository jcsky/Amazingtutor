class EvalutionsController < ApplicationController

  before_action :set_appointment

  def index
    @evalutions = Evalution.all
  end

  def new
    @evalution = Evalution.new
  end

  def create


    @evalutions = @appointment.evalutions.where(user_id: 3)

    if current_user != @appointment.user || @evalutions.count != 0
      redirect_to root_path
    else
      @evalution = Evalution.new(:comment => params[:comment], :rating => params[:rating], :user_id => current_user.id, :appointment_id => @appointment.id, :teacher_id => @appointment.teacher_id )
      @evalution.save
      flash[:notice] = "successfully created"
    end


    @evalutions = Evalution.where(appointment_id: @appointment)

    if @evalutions.blank?
      @raty = 0
    else
      @raty = @evalutions.average(:rating).round(2).to_f
    end

    respond_to do |format|
      format.html
    end


  end

  def show
    @evalution = Evalution.find(params[:id])

    respond_to do |format|
      format.html
      format.json {
        render :json => { :id => @appointment.id, :rating => @evalution.rating }
      }
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
