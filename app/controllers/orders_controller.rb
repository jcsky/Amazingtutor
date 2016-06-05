
class OrdersController < ApplicationController

  before_action :authenticate_user!, except: :checkout_pay2go
  before_action :set_student_section, :only => :show
  protect_from_forgery except: :checkout_pay2go

  def index
    @orders = Order.all
  end

  def show
    redirect_to :back if current_user.teacher.id == params[:teacher_id]

  end

  def new
    redirect_to :back if current_user.teacher.id == params[:teacher_id]
    @order = Order.new
    @order.teacher_id = params[:teacher_id]
  end

  def create
    # raise
     @user = current_user
     @order = @user.orders.create!( order_params )
      if @order.save
        redirect_to user_order_path(@order.user, @order)
      else
        render :new
      end
  end

  def checkout_pay2go
    @order = current_user.orders.find(params[:id])

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


   protected

   def order_params
     params.require(:order).permit(:name, :amount, :email, :teacher_id, :session )
   end

   def set_student_section
     @order = current_user.orders.find(params[:id])
     @student_available_section = @order.user.user_available_sections.where(:teacher_id => @order.teacher_id).first
   end


end
