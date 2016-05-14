class Teacher < ActiveRecord::Base
  belongs_to :user

  has_many :teacher_languageships
  has_many :languages, through: :teacher_languageships

  has_many :appointments
  has_many :evaluations, :as => :evaluatable

  has_many :experiences
  has_many :certificates
  has_many :educations

  has_many :orders
  has_many :appointments
  accepts_nested_attributes_for :teacher_languageships , allow_destroy: true
  accepts_nested_attributes_for :languages , allow_destroy: true
  accepts_nested_attributes_for :experiences , allow_destroy: true
  accepts_nested_attributes_for :certificates , allow_destroy: true
  accepts_nested_attributes_for :educations , allow_destroy: true


  def uniq_language
    array = []
    params[:teacher][:languages_attributes].map { |x| array << x[:language] }
    array.uniq
  end

  def youtube_website
    if  self.youtube.blank?
      'https://www.youtube.com/embed/z3XVg9wRVmk'
    else
      self.youtube.gsub('watch?v=','embed/')
    end
  end

  def hangouts_url
    if self.hangouts_url.blank?

      charset = (0...4).map { ('a'..'z').to_a[ rand(26)] }.join
      url =  "https://talkgadget.google.com/hangouts/_/i"+charset+"m5jzffaheagjkaa5wzj7y2?hl=zh-TW"
      self.hangouts_url = url
    end
  end








end
