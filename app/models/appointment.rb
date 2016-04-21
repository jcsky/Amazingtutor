class Appointment < ActiveRecord::Base
  belongs_to :user

  has_many :evaluations
  has_many :available_section
end
