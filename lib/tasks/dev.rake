namespace :dev do
  task fake_user: :environment do
    20.times do
      User.create!(username: Faker::Name.name, email: Faker::Internet.email,password: 12345678 )
    end
  end
end
