class Scholarship < ActiveRecord::Base
  belongs_to :user
  belongs_to :new_user, :class_name => "User"
end
