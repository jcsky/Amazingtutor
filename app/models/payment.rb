class Payment < ActiveRecord::Base

  serialize :params, JSON

  belongs_to :order

  def self.find_and_process(params)
    result = JSON.parse( params['Result'] )

    payment = self.find(result['MerchantOrderNo'].to_i)
    payment.paid = params['Status'] == 'SUCCESS'
    payment.params = params
    payment
  end

  def self.find_and_process_for_paypal(params)
    payment = self.find( params[:invoice] )

    if Rails.env.development?
      payment.paid = ( params[:payment_status] == 'Pending' )
    else
      payment.paid = ( params[:payment_status] == 'Completed' )
    end

    payment.params = params
    payment
  end

end
