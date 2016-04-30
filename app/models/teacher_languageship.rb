class TeacherLanguageship < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :language
end
