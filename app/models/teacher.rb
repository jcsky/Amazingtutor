class Teacher < ActiveRecord::Base
  belongs_to :user

  has_many :teacher_languageships
  has_many :languages, through: :teacher_languageships

  has_many :appointments
  has_many :evalutions

  has_many :experiences
  has_many :certificates
  has_many :educations
  has_many :appointments

  accepts_nested_attributes_for :teacher_languageships, allow_destroy: true
  accepts_nested_attributes_for :languages, allow_destroy: true
  accepts_nested_attributes_for :experiences, allow_destroy: true
  accepts_nested_attributes_for :certificates, allow_destroy: true
  accepts_nested_attributes_for :educations, allow_destroy: true

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
end
