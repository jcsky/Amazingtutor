module FactoryHelpers

  def create_user
    User.create!(:email => Faker::Internet.email,
                 :password => 'qwer4321')
  end
end