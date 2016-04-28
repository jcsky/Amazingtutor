class OrdersController < ApplicationController

  before_action :authenticate_user!, except: :checkout_pay2go
  before_action :set_student_section, :only => :show
  protect_from_forgery except: :checkout_pay2go

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
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

   protected

   def order_params
     params.require(:order).permit(:name, :amount, :email, :teacher_id )
   end

   def set_student_section
     @order = current_user.orders.find(params[:id])
     @student_available_section = @order.user.user_available_sections.where(:teacher_id => @order.teacher_id).first
   end


end
