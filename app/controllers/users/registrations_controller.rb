class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
    if params[:scholarship]
      cookies[:scholarship] = params[:scholarship]
    end
  end

  # POST /resource
  def create
    # if cookies[:scholarship].present? || params[:scholarship]
    # key = OpenSSL::Digest::SHA256.new('amazing_scholarship_tutor_lululala').digest
    # crypt = ActiveSupport::MessageEncryptor.new(key)
    # @decrypted_data = crypt.decrypt_and_verify(cookies[:scholarship])
    # rasie
    # end
    #
    # super do |resource|
    #   if resource.id.present?
    #     resource.time_zone = cookies['browser.timezone']
    #     resource.save!
    #   end
    # end

     build_resource(sign_up_params)
     resource.save
     yield resource if block_given?
     if resource.persisted?
       if resource.active_for_authentication?
         set_flash_message! :notice, :signed_up
         sign_up(resource_name, resource)
         respond_with resource, location: after_sign_up_path_for(resource)
       else
         set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
         expire_data_after_sign_in!
         respond_with resource, location: after_inactive_sign_up_path_for(resource)
       end
     else
       clean_up_passwords resource
       set_minimum_password_length
      #  respond_with resource
      flash[:alert] = resource.errors.full_messages.each {|x| flash[x] = x}
      redirect_to :back
     end
     if resource.id.present?
       resource.time_zone = cookies['browser.timezone']
       resource.username = resource.email.split("@").first
       resource.save!
       if cookies[:scholarship]
         key = OpenSSL::Digest::SHA256.new('amazing_scholarship_tutor_lululala').digest
         crypt = ActiveSupport::MessageEncryptor.new(key)
         @decrypted_data = crypt.decrypt_and_verify(cookies[:scholarship])
         raise
       end
     end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up)
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
