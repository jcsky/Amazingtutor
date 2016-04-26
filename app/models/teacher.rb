class Teacher < ActiveRecord::Base
  belongs_to :user
  has_many :languages
  accepts_nested_attributes_for :languages , allow_destroy: true
end
