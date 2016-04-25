class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one  :profile
  has_one  :teacher_profile
  has_many :certificates
  has_many :experiences
  has_many :remarks
  has_many :second_tongues
  has_many :orders
  has_many :appointments
  has_many :user_available_sections
  accepts_nested_attributes_for :profile

  def get_profile
  if self.profile
    self.profile
  else
    self.create_profile
  end
end


end
