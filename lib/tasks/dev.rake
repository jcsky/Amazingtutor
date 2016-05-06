namespace :dev do
  task fake_user: :environment do
    User.delete_all
    Teacher.delete_all
    AvailableSection.delete_all
    Appointment.delete_all
    UserAvailableSection.delete_all
    30.times do
      @user = User.create
      @user.update(first_name: Faker::Name.name.split(' ').first, last_name: Faker::Name.name.split(' ').last,
                   email: Faker::Internet.email, password: 12345678 )
    end
    8.times do
      @user = User.create
      @user.update(first_name: Faker::Name.name.split(' ').first, last_name: Faker::Name.name.split(' ').last,
                   email: Faker::Internet.email, password: 12345678,authority: "teacher")
      @user.create_teacher(introduction: Faker::Lorem.paragraph(8), youtube: 'https://www.youtube.com/watch?v=xWsfailxV3U',
                                trial_fee: rand(10..30) * 10, one_fee: rand(10..30) * 20, five_fee: rand(10..30) * 50,
                                ten_fee: rand(10..30) * 100 ,check: "checked" , avg_rating: rand(3..5))
      rand(1..3).times do
        @user.teacher.teacher_languageships.create(language_id: rand(1..10))
      end
    end
  end
end
