
class OrdersController < ApplicationController

  before_action :authenticate_user!, except: :checkout_pay2go
  before_action :set_student_section, :only => :show
  protect_from_forgery except: :checkout_pay2go

  def index
    @orders = Order.all
  end

  def show
    redirect_to :root_path if current_user.teacher.try(:id) == params[:teacher_id].to_i
  end

  def new
    redirect_to root_path if current_user.teacher.try(:id) == params[:teacher_id].to_i
    @order = Order.new
    @order.teacher_id = params[:teacher_id]
  end

  def create
    session = params[:order][:session]
    teacher = Teacher.find params[:order][:teacher_id]
    email = params[:order][:email]

    if session == "1"
      amount = teacher.one_fee
    elsif session == "5"
      amount = teacher.five_fee*5
    elsif session == "10"
      amount = teacher.ten_fee*10
    elsif session == "trial"
      amount = teacher.trial_fee
    end

    if amount
      @user = current_user
      @order = @user.orders.create!( teacher: teacher,
                                     amount: amount,
                                     session: session,
                                     email: email)
       if @order.save
         redirect_to user_order_path(@order.user, @order)
       else
         render :new
       end
    else
      render :status => :expectation_failed, :text => "expectation_failed"
    # if teacher.check_fee(params[:order][:amount],params[:order][:session]) == true
    end
  end

  def checkout_pay2go
    @order = current_user.orders.find(params[:id])
    puts @order.amount

    @order.amount = Money.new(@order.amount*100,"USD").exchange_to("TWD")

    puts @order.amount
    if @order.paid?
      redirect_to :back, alert: 'already paid!'
    else
      @payment = Payment.create!( :order => @order,
                                  :payment_method => params[:payment_method] )
      render :layout => false
    end
  end

  def checkout_paypal
    @order = current_user.orders.find(params[:id])

    if @order.paid?
      redirect_to :back, alert: 'already paid!'
    else
      @payment = Payment.create!( :order => @order, :payment_method => "paypal" )
      render :layout => false
    end
  end

  def thankyou
    order = Order.find(params[:order])
    if current_user.id == order.user_id
      if order.paid?
        @order = order
        @teacher_name = Teacher.find(@order.teacher_id).user.username
      else
      end
    else
      redirect_to root_path
    end
  end

   protected

   def order_params
     params.require(:order).permit(:name, :amount, :email, :teacher_id, :session )
   end

   def set_student_section
     @order = current_user.orders.find(params[:id])
     @student_available_section = @order.user.user_available_sections.where(:teacher_id => @order.teacher_id).first
   end


end
