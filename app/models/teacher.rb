class Teacher < ActiveRecord::Base
  belongs_to :user
  has_many :languages , :through => :teacher_languageships
  has_many :teacher_languageships
  has_many :experiences
  has_many :certificates
  has_many :educations
  has_many :orders
  accepts_nested_attributes_for :teacher_languageships , allow_destroy: true
  accepts_nested_attributes_for :languages , allow_destroy: true
  accepts_nested_attributes_for :experiences , allow_destroy: true
  accepts_nested_attributes_for :certificates , allow_destroy: true
  accepts_nested_attributes_for :educations , allow_destroy: true

  def uniq_language
    array = []
    params[:teacher][:languages_attributes].map{|x| array << x[:language]}
    array.uniq
  end
end
