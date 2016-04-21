class AvailableSection < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :appointment

end
