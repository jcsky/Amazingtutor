class Evalution < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :user
  belongs_to :teacher
end
