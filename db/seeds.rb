# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Teacher.delete_all
AvailableSection.delete_all
Appointment.delete_all
UserAvailableSection.delete_all
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
               :youtube => 'https://www.youtube.com/embed/FuedTgMzSJQ'
)
@avaiablesection=AvailableSection.create(:start => Time.now.at_beginning_of_day,
                                         :end => Time.now.at_beginning_of_day + 6.hours,
                                         :teacher_id => @teacher1.id)
@avaiablesection=AvailableSection.create(:start => Time.now.at_beginning_of_day + 7.hours,
                                         :end => Time.now.at_beginning_of_day + 15.hours,
                                         :teacher_id => @teacher1.id)
Appointment.create(:teacher_id => @teacher1.id,
                   :student_id => @student2.id,
                   :section => 2,
                   :start => Time.now.at_beginning_of_day + 4.hours + 30*60,
                   :end => Time.now.at_beginning_of_day  + 5.hours + 30*60 )
UserAvailableSection.create(:teacher_id => @teacher1.id,:user_id=>@student1.id,:available_section => 20)