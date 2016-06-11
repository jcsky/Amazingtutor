class Education < ActiveRecord::Base
  belongs_to :teacher
  # validates :school, :major,:start,:end, presence: true
end
