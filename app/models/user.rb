class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_one :teacher
  has_many :remarks
  has_many :orders
  has_many :appointments
  has_many :evaluations, as: :evaluatable
  has_many :user_available_sections
  has_many :scholarships
  has_many :new_user, through: :scholarships
  has_many :scholarships
  has_many :new_user, through: :scholarships
  has_many :messages
  has_many :friends, through: :messages

  has_attached_file :image, styles: {
    medium: '300x300>',
    thumb: '100x100>'
  },
  :url => ":s3_domain_url",
  :path => 'users/:id/avatar/:style_:basename.:extension',
  :storage => :s3,
  region: 'ap-northeast-1',
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
    }


  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..1.megabytes }

  validates :image, presence: true

  before_create :generate_authentication_token

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end

  def get_teacher
    if authority == 'teacher'
      if teacher.nil?
        create_teacher
      else
        teacher
      end
    end
  end

  def display_name
    if username?
      username
    elsif first_name?
      first_name
    elsif last_name?
      first_name
    else
      email.split('@').first
    end
  end


  accepts_nested_attributes_for :teacher

  serialize :fb_raw_data
  serialize :google_raw_data

  def self.from_facebook_omniauth(auth, browser_time_zone)
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
    user.alternate_email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.fb_raw_data = auth
    user.time_zone = browser_time_zone
    user.fb_pic = auth.info.image
    user.username = auth.info.name
    user.save!
    user
  end

  def connect_to_facebook(auth)
    #   檢查這個帳戶是不是有被關聯過
    # user = User.find_by_fb_uid(auth.uid)

    if User.find_by_fb_uid(auth.uid).id != id
      return false
    else
      self.fb_uid = auth.uid
      self.fb_token = auth.credentials.token
      self.fb_raw_data = auth
      save!
      if fb_uid.nil?
        return true
      elsif fb_uid == auth.uid
        return 'update'
      end
    end
  end

  def self.from_google_omniauth(auth, browser_time_zone)
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
    user.alternate_email = auth.extra.raw_info.email
    user.password = Devise.friendly_token[0, 20]
    user.google_raw_data = auth
    user.locale = auth.extra.raw_info.locale
    user.time_zone = browser_time_zone
    user.google_pic = auth.info.image
    user.username = auth.info.name
    user.save!
    user
  end

  def connect_to_google_omniauth(auth)
    #   檢查這個帳戶是不是有被關聯過
    if User.find_by_google_uid(auth.uid).id != id
      return false
    else
      self.google_uid = auth.uid
      self.google_token = auth.credentials.token
      self.google_raw_data = auth
      save!
      if google_uid.nil?
        return true
      elsif google_uid == auth.uid
        return 'update'
      end
    end
  end

end
