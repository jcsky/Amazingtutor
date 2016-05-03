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

      redirect_to mytutor_user_path(@order.user)
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
