class Teacher < ActiveRecord::Base
  belongs_to :user
  has_many :second_tongues
  accepts_nested_attributes_for :second_tongues
end
