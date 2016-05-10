namespace :dev do
  task fake_user: :environment do
    User.delete_all
    Teacher.delete_all
    AvailableSection.delete_all
    Appointment.delete_all
    UserAvailableSection.delete_all
    Evaluation.delete_all
    Language.delete_all

    @user_a = User.create!(first_name: "Wood", last_name: "River",
                          email: "a@gmail.com", password: 12345678, authority: "teacher")
    @teacher_a = Teacher.create!(user: @user_a, one_fee: 100, five_fee: 500, ten_fee: 900, check: "checked",
                         introduction: Faker::Lorem.paragraph(8))

    @user_b = User.create!(first_name: "RooD", last_name: "Omma",
                          email: "b@gmail.com", password: 12345678)

    @appointment_1 = Appointment.create!(user_id: @user_b.id, teacher_id: @teacher_a.id)
    @appointment_2 = Appointment.create!(user_id: @user_b.id, teacher_id: @teacher_a.id)


    1.times do
      @user = User.create
      @user.update(first_name: "LU", last_name: "Yi",
                   email: "admin@gmail.com", password: 12345678,admin: true ,authority: "teacher")
    end
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
    Teacher.first.update(youtube: "https://www.youtube.com/watch?v=jqjSsoKyWGo")
    Teacher.limit(1).offset(2).first.update(youtube: "https://www.youtube.com/watch?v=ExCm_FYbu94")
    Teacher.limit(1).offset(3).first.update(youtube: "https://www.youtube.com/watch?v=rMqSQvmmM4A")
    Teacher.limit(1).offset(4).first.update(youtube: "https://www.youtube.com/watch?v=gkVpNq4-wqs")
    Teacher.limit(1).offset(5).first.update(youtube: "https://www.youtube.com/watch?v=gSbOa1SJ0TQ")
    Teacher.limit(1).offset(6).first.update(youtube: "https://www.youtube.com/watch?v=diVhgrqqFhc")
    Teacher.limit(1).offset(7).first.update(youtube: "https://www.youtube.com/watch?v=YUR38UEgjPE")
    Teacher.last.update(youtube: "https://www.youtube.com/watch?v=diVhgrqqFhc")
    Language.create(language: "English")
    Language.create(language: "Chinese")
    Language.create(language: "German")
    Language.create(language: "Japan")
    Language.create(language: "Indian")
    Language.create(language: "Vietnamese")
    Language.create(language: "Italian")
    Language.create(language: "Korean")
    Language.create(language: "Ukrainian")
    Language.create(language: "French")
  end
end
