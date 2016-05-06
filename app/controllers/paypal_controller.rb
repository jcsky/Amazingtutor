class PaypalController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :update_paypal_data

  def webhook
    render nothing: true
  end

  def redirect
    @order = @payment.order
    byebug
    if @payment.paid?

      ActiveRecord::Base.transaction do
        @order.paid = true
        @order.save!
        @teacher_available_section = @order.user.user_available_sections.find_or_create_by(:teacher_id => @order.teacher_id)
        new_section = case @order.session
                      when '1'  then 2
                      when '5'  then 10
                      when '10' then 20
                      else # 'trial'
                        @teacher_available_section.trailed = true
                        @teacher_available_section.save
                        1
                      end
        # @teacher_available_section.available_section should have default 0
        @teacher_available_section.available_section += new_section
        @teacher_available_section.save
      end
    end
    byebug
    redirect_to mytutor_user_path(@order.user)
    byebug
  end

  protected

  def update_paypal_data
    params.permit! # Permit all Paypal input params
    @payment = Payment.find_and_process_for_paypal( params )
    @payment.save
  end

end
