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
@student1 = User.create!(:email => Faker::Internet.email,
                         :password => 'qwer4321')
@student2 = User.create!(:email => Faker::Internet.email,
                         :password => 'qwer4321')
@user1 = User.create!(:email => Faker::Internet.email,
                         :password => 'qwer4321')
@user2 = User.create!(:email => Faker::Internet.email,
                         :password => 'qwer4321')
@teacher1 = Teacher.create!(:user => @user1,
                            :introduction => 'FakerLorem',
                            :youtube => 'https://www.youtube.com/embed/FuedTgMzSJQ')
@teacher2 = Teacher.create!(:user => @user2,
                            :introduction => 'FakerLorem',
                            :youtube => 'https://www.youtube.com/embed/FuedTgMzSJQ')

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
                   :end => Time.current.at_beginning_of_day + 1.days  + 5.hours + 30*60 )
Appointment.create(:teacher => @teacher1,
                   :user => @student2,
                   :section => 2,
                   :start => Time.current.at_beginning_of_day + 1.days + 1.hours + 30*60,
                   :end => Time.current.at_beginning_of_day + 1.days  + 2.hours + 30*60 )
UserAvailableSection.create(:teacher => @teacher1,:user=>@student1,:available_section => 20)
                  #  :start => Time.now.at_beginning_of_day + 4.hours + 30*60,
                  #  :end => Time.now.at_beginning_of_day  + 5.hours + 30*60 )
