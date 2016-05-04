class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :teacher

  has_many :payments

end
