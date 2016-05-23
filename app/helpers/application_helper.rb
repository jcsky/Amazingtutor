module ApplicationHelper

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

  def generate_pay2go_params(payment)
    pay2go_params = {
      MerchantID: '11783008',
      RespondType: 'JSON',
      TimeStamp: payment.created_at.to_i,
      Version: '1.2',
      LangType: 'en',
      MerchantOrderNo: "#{payment.id}AT#{Rails.env.upcase[0]}",
      Amt: payment.order.amount,
      ItemDesc: "Order #{payment.order.id}",
      ReturnURL: 'http://amazingtutor.ns1.name/pay2go/return',
      NotifyURL: 'http://amazingtutor.ns1.name/pay2go/notify',
      Email: payment.order.email,
      LoginType: 0,
      CREDIT: 1,
      WEBATM: 0,
      VACC: 0,
      CVS: 0,
      BARCODE: 0
    }

    raw = pay2go_params.slice(:Amt, :MerchantID, :MerchantOrderNo, :TimeStamp, :Version).sort.map! { |ary| "#{ary.first}=#{ary.last}" }.join('&')
    hash_key = 'WShuHxza5S19p6mzmSR7rN3CuoiMhrMe'
    hash_iv = 'k3I2AicGaePAlc9I'
    str = "HashKey=#{hash_key}&#{raw}&HashIV=#{hash_iv}"
    check_value = Digest::SHA256.hexdigest(str).upcase

    pay2go_params[:CheckValue] = check_value

    pay2go_params
    end

  def generate_paypal_params(payment)
    {
      business: Rails.application.secrets.paypal_account,
      cmd: '_xclick',
      upload: 1,
      return: "#{Rails.application.secrets.app_host}/paypal/redirect",
      invoice: payment.id,
      amount: payment.order.amount,
      currency_code: 'TWD',
      item_name: 'Chinese Tutor Class',
      item_number: payment.id,
      quantity: '1',
      notify_url: "#{Rails.application.secrets.app_host}/paypal/webhook"
    }
  end
end
