class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one  :teacher
  has_many :certificates
  has_many :experiences
  has_many :remarks
  has_many :second_tongues
  has_many :orders
  has_many :appointments
  has_many :user_available_sections


end
