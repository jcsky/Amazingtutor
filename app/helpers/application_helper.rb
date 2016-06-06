module ApplicationHelper


  def generate_pay2go_params(payment)
        pay2go_params = {
          MerchantID: Pay2go.merchant_id,
          RespondType: "JSON",
          TimeStamp: payment.created_at.to_i,
          Version: "1.2",
          LangType: "en",
          MerchantOrderNo: payment.external_id,
          Amt: payment.amount,
          ItemDesc: payment.name,
          ReturnURL: pay2go_return_url,
          NotifyURL: Pay2go.notify_url,
          Email: payment.email,
          LoginType: 0,
          CREDIT: 1,
          WEBATM: 0,
          VACC: 0,
          CVS: 0,
          BARCODE: 0
        }

        pay2go = Pay2go.new(pay2go_params)
        pay2go_params[:CheckValue] = pay2go.make_check_value
        pay2go_params
    end

  def scholarship_test
      key = OpenSSL::Digest::SHA256.new('amazing_scholarship_tutor_lululala').digest
      crypt = ActiveSupport::MessageEncryptor.new(key)
      begin
        @decrypted_data = crypt.decrypt_and_verify(params[:scholarship])
      rescue
         "error"
      end
  end

  def scholarship_name
      key = OpenSSL::Digest::SHA256.new('amazing_scholarship_tutor_lululala').digest
      crypt = ActiveSupport::MessageEncryptor.new(key)
      begin
      @decrypted_data = crypt.decrypt_and_verify(params[:scholarship])
      @old_user_name = User.where(email: @decrypted_data).first.email.split('@').first
      rescue
      end
  end



  def generate_paypal_params(payment)
    {
      business: Rails.application.secrets.paypal_account,
      cmd: '_xclick',
      upload: 1,
      return: "#{Rails.application.secrets.app_host}/paypal/redirect",
      invoice: payment.id,
      amount: payment.order.amount,
      currency_code: 'USD',
      item_name: 'Chinese Tutor Class',
      item_number: payment.id,
      quantity: '1',
      notify_url: "#{Rails.application.secrets.app_host}/paypal/webhook"
    }
  end
end
