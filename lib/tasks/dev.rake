namespace :dev do
  task fake_user: :environment do
    20.times do
      User.create!(first_name: Faker::Name.name.split(' ').first, last_name: Faker::Name.name.split(' ').last,
                   email: Faker::Internet.email, password: 12_345_678)
      User.last.teacher.create!(introduction: Faker::Lorem.paragraph(8), youtube: 'https://www.youtube.com/watch?v=xWsfailxV3U',
                                trial_fee: rand(10..30) * 10, one_fee: rand(10..30) * 20, five_fee: rand(10..30) * 50,
                                ten_fee: rand(10..30) * 100, avg_rating: (rand(10..50) / 10))
    end
  end
end
