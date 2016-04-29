class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  has_one :teacher
  has_many :remarks
  has_many :orders
  has_many :appointments
  has_many :user_available_sections

  def display_name
    email.split("@").first
  end

  accepts_nested_attributes_for :teacher

  serialize :fb_raw_data
  serialize :google_raw_data

  def self.from_facebook_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid(auth.uid)
    if user
      user.fb_token = auth.credentials.token
      user.fb_raw_data = auth
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email(auth.info.email)
    if existing_user
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      existing_user.fb_raw_data = auth
      existing_user.save!
      reauth.credentialscredentials.tokenturn existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.fb_raw_data = auth
    user.save!
    return user
  end


  def self.from_google_omniauth(auth)
    # 可用參數
    # auth.uid
    # auth.credentialscredentials.token
    # auth.extra.id_token
    # auth.extra.raw_info    picture name email local
    user = User.find_by_google_uid(auth.uid)
    # Case 1: Find existing user by google uid
    if user
      user.google_token = auth.credentials.token
      user.google_raw_data = auth
      user.save!
      return user
    end

    # # Case 2: Find existing user by email
    existing_user = User.find_by_email(auth.extra.raw_info.email)
    if existing_user
      existing_user.google_uid = auth.uid
      existing_user.google_token = auth.credentials.token
      existing_user.google_raw_data = auth
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.google_uid = auth.uid
    user.google_token = auth.credentials.token
    user.email = auth.extra.raw_info.email
    user.password = Devise.friendly_token[0, 20]
    user.google_raw_data = auth
    user.locale = auth.extra.raw_info.locale
    user.save!
    return user
  end
end
