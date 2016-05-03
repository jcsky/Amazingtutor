module ApplicationHelper

  def generate_pay2go_params(payment)
        pay2go_params = {
          MerchantID: "11783008",
          RespondType: "JSON",
          TimeStamp: payment.created_at.to_i,
          Version: "1.2",
          LangType: "en",
          MerchantOrderNo: "#{payment.id}ACA#{Rails.env.upcase[0]}",
          Amt: payment.order.amount,
          ItemDesc: "Order #{payment.order.id}",
          ReturnURL: "http://localhost:3000/pay2go/return",
          NotifyURL: "http://requestb.in/1c2xxun1",
          Email: payment.order.email,
          LoginType: 0,
          CREDIT: 1,
          WEBATM: 0,
          VACC: 0,
          CVS: 0,
          BARCODE: 0
        }

        raw = pay2go_params.slice(:Amt, :MerchantID, :MerchantOrderNo, :TimeStamp, :Version).sort.map!{|ary| "#{ary.first}=#{ary.last}"}.join('&')
        hash_key = "WShuHxza5S19p6mzmSR7rN3CuoiMhrMe"
        hash_iv = "k3I2AicGaePAlc9I"
        str = "HashKey=#{hash_key}&#{raw}&HashIV=#{hash_iv}"
        check_value = Digest::SHA256.hexdigest(str).upcase

        pay2go_params[:CheckValue] = check_value

        pay2go_params
    end

end
