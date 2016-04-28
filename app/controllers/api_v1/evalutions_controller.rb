class ApiV1::EvalutionsController < ApiController

  def index
    render :json => { :message => "Test"}
  end

  def create
    @evalution = Evalution.new( :rating => params[:rating] )
    @evalution.appointment = @appointment
    @evalutions = Evalution.where(appointment_id: @appointment)

    if @topic.save
     render :json => { :rating=> @evalution.rating }
    else
      render :json => { :message => "failed", :errors => @evalution.errors }, :status => 400
    end
  end

end