class Language < ActiveRecord::Base
  has_many :teachers , :through => :teacher_languageships
  has_many :teacher_languageships
end
