class Pay2goController < ApplicationController

  skip_before_action :verify_authenticity_token

  def return
      result = nil
      ActiveRecord::Base.transaction do
        @payment = Payment.find_and_process( json_data )
        result = @payment.save
      end

      unless result
        flash[:alert] = t("registration.error.failed_pay")
      end

      @order = @payment.order
      if @payment.paid?

        ActiveRecord::Base.transaction do
          @order.paid = true
          @order.save!
          @teacher_available_section = @order.user.user_available_sections.where(:teacher_id => @order.teacher_id).first
          if  @teacher_available_section
              @teacher_available_section.available_section += 2
              @teacher_available_section.save
          else
            @teacher_available_section = @order.user.user_available_sections.new( :teacher_id => @order.teacher_id )
            @teacher_available_section.available_section = 2
            @teacher_available_section.save!
          end
        end
      end

      redirect_to user_order_path(@order.user, @order)
    end

    def notify
      result = nil
      ActiveRecord::Base.transaction do
        @payment = PaymentPay2go.find_and_process( json_data )
        result = @payment.save
      end

      if result
        render :text => "1|OK"
      else
        render :text => "0|ErrorMessage"
      end
    end

    private

    def json_data
      JSON.parse( params["JSONData"] )
    end

end
