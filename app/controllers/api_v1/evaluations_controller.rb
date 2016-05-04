class ApiV1::EvaluationsController < ApiController

  def index
    render :json => { :message => "Test"}
  end

  def create
    @evaluation = Evaluation.new( :rating => params[:rating] )
    @evaluation.appointment = @appointment
    @evaluations = Evaluation.where(appointment_id: @appointment)

    if @topic.save
     render :json => { :rating=> @evaluation.rating }
    else
      render :json => { :message => "failed", :errors => @evaluation.errors }, :status => 400
    end
  end

  def show
    @evaluation = Evaluation.find(params[:id])
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:appointment_id])
  end

end