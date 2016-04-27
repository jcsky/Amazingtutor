class Teacher < ActiveRecord::Base
  belongs_to :user
  has_many :languages
  has_many :experiences
  has_many :certificates
  has_many :educations
  accepts_nested_attributes_for :languages , allow_destroy: true
  accepts_nested_attributes_for :experiences , allow_destroy: true
  accepts_nested_attributes_for :certificates , allow_destroy: true
  accepts_nested_attributes_for :educations , allow_destroy: true

  def uniq_language
    x = params
    array = []
    z = params[:teacher][:languages_attributes].count
    for i in 0..count-1
      params[:teacher][:languages_attributes][i]
    end
  end
end
