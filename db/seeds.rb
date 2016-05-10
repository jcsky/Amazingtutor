# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.delete_all
# Teacher.delete_all
# AvailableSection.delete_all
# Appointment.delete_all
# UserAvailableSection.delete_all

User.delete_all
Teacher.delete_all
AvailableSection.delete_all
Appointment.delete_all
UserAvailableSection.delete_all
Evaluation.delete_all
Language.delete_all


@student1 = User.create!(:email => Faker::Internet.email,
                         :password => 'qwer4321')
@student2 = User.create!(:email => Faker::Internet.email,
                         :password => 'qwer4321')
@user1 = User.create!(:email => Faker::Internet.email,
                      :password => 'qwer4321')
@user2 = User.create!(:email => Faker::Internet.email,
                      :password => 'qwer4321')
@teacher1 = Teacher.create!(:user => @user1,
                            :introduction => Faker::Lorem.paragraph(8),
                            :youtube => 'https://www.youtube.com/embed/FuedTgMzSJQ',
                            :trial_fee => 3,
                            :one_fee => 5,
                            :five_fee => 25,
                            :ten_fee => 50)
@teacher2 = Teacher.create!(:user => @user2,
                            :introduction => Faker::Lorem.paragraph(8),
                            :youtube => 'https://www.youtube.com/embed/FuedTgMzSJQ',
                            :trial_fee => 3,
                            :one_fee => 5,
                            :five_fee => 25,
                            :ten_fee => 50)

@avaiablesection=AvailableSection.create(:start => Time.current.at_beginning_of_day + 1.days,
                                         :end => Time.current.at_beginning_of_day+ 1.days + 6.hours,
                                         :teacher => @teacher1)
@avaiablesection=AvailableSection.create(:start => Time.current.at_beginning_of_day+ 1.days + 7.hours,
                                         :end => Time.current.at_beginning_of_day+ 1.days + 15.hours,
                                         :teacher => @teacher1)
Appointment.create(:teacher => @teacher1,
                   :user => @student2,
                   :section => 2,
                   :start => Time.current.at_beginning_of_day + 1.days + 4.hours + 30*60,
                   :end => Time.current.at_beginning_of_day + 1.days + 5.hours + 30*60)
Appointment.create(:teacher => @teacher1,
                   :user => @student2,
                   :section => 2,
                   :start => Time.current.at_beginning_of_day + 1.days + 1.hours + 30*60,
                   :end => Time.current.at_beginning_of_day + 1.days  + 2.hours + 30*60 )
UserAvailableSection.create(:teacher => @teacher1,:user=>@student1,:available_section => 20)
                  #  :start => Time.now.at_beginning_of_day + 4.hours + 30*60,
                  #  :end => Time.now.at_beginning_of_day  + 5.hours + 30*60 )

                  @user_a = User.create!(first_name: "Wood", last_name: "River",
                                        email: "a@gmail.com", password: 12345678, authority: "teacher")
                  @teacher_a = Teacher.create!(user: @user_a, one_fee: 100, five_fee: 500, ten_fee: 900, check: "checked",
                                              introduction: Faker::Lorem.paragraph(8),youtube: 'https://www.youtube.com/watch?v=xWsfailxV3U',
                                              avg_rating: rand(3..5))

                  @user_b = User.create!(first_name: "RooD", last_name: "Omma",
                                        email: "b@gmail.com", password: 12345678)

                  @appointment_1 = Appointment.create!(user_id: @user_b.id, teacher_id: @teacher_a.id)
                  @appointment_2 = Appointment.create!(user_id: @user_b.id, teacher_id: @teacher_a.id)
                  @appointment_3 = Appointment.create!(user_id: @user_b.id, teacher_id: @teacher_a.id)

                  @user_b.evaluations.create(rating: rand(4..5), comment: Faker::Lorem.sentence(3),
                                             evaluated_id: @teacher_a.id, appointment_id: @appointment_2.id)
                  @user_b.evaluations.create(rating: rand(4..5), comment: Faker::Lorem.sentence(4),
                                             evaluated_id: @teacher_a.id, appointment_id: @appointment_3.id)

                  1.times do
                    @user = User.create
                    @user.update(first_name: "LU", last_name: "Yi",
                                 email: "admin@gmail.com", password: 12345678,admin: true ,authority: "teacher")
                    @teacher_1 = Teacher.create(user: @user, one_fee: 100, five_fee: 500, ten_fee: 900, check: "checked",
                                                introduction: Faker::Lorem.paragraph(8),
                                                avg_rating: rand(3..5))

                    @newAppointment_1 = Appointment.create(teacher_id: @teacher_1.id, user_id: @user.id)

                    @user_b.evaluations.create(rating: rand(4..5), comment: Faker::Lorem.sentence(3),
                                                          evaluated_id: @teacher_1.id, appointment_id: @newAppointment_1.id)
                    @user_b.evaluations.create(rating: rand(3..5), comment: Faker::Lorem.sentence(3),
                                                          evaluated_id: @teacher_1.id, appointment_id: @newAppointment_1.id)
                    @user_b.evaluations.create(rating: rand(4..5), comment: Faker::Lorem.sentence(3),
                                                          evaluated_id: @teacher_1.id, appointment_id: @newAppointment_1.id)

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
                    @newTeacher = @user.create_teacher(introduction: Faker::Lorem.paragraph(8), youtube: 'https://www.youtube.com/watch?v=xWsfailxV3U',
                                              trial_fee: rand(10..30) * 10, one_fee: rand(10..30) * 20, five_fee: rand(10..30) * 50,
                                              ten_fee: rand(10..30) * 100 ,check: "checked" , avg_rating: rand(3..5))

                    @newAppointment = Appointment.create(teacher_id: @newTeacher.id, user_id: @user.id)

                    @user_b.evaluations.create(rating: rand(4..5), comment: Faker::Lorem.sentence(3),
                                             evaluated_id: @newTeacher.id, appointment_id: @newAppointment.id)
                    @user_b.evaluations.create(rating: rand(3..5), comment: Faker::Lorem.sentence(3),
                                             evaluated_id: @newTeacher.id, appointment_id: @newAppointment.id)
                    @user_b.evaluations.create(rating: rand(4..5), comment: Faker::Lorem.sentence(3),
                                             evaluated_id: @newTeacher.id, appointment_id: @newAppointment.id)

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

                  puts("done!")
