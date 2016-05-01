# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@student1 = User.create!(:email => Faker::Internet.email,
             :password => 'qwer4321')
@student2 = User.create!(:email => Faker::Internet.email,
             :password => 'qwer4321')
@teacher1 = User.create!(:email => Faker::Internet.email,
             :password => 'qwer4321')
@teacher2 = User.create!(:email => Faker::Internet.email,
             :password => 'qwer4321')
Teacher.create(:user_id => @teacher1.id,
            :introduction => Faker::Lorem,
           :youtube=> 'https://www.youtube.com/embed/FuedTgMzSJQ'
              )
@avaiablesection=AvailableSection.create(:start => '2016-05-01 00:00:00'.to_time,
                                         :end => '2016-05-01 06:00:00'.to_time,
                                         :teacher_id => @teacher1.id)
@avaiablesection=AvailableSection.create(:start => '2016-05-01 09:00:00'.to_time,
                                         :end => '2016-05-01 12:00:00'.to_time,
                                         :teacher_id => @teacher1.id)
Appointment.create(:teacher_id => @teacher1.id,
                   :student_id => @student2.id,
                   :start => '2016-05-01 03:30:00'.to_time,
                   :end =>'2016-05-01 04:30:00'.to_time)
