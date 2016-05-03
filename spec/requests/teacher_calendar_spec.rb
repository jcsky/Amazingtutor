require 'rails_helper'

RSpec.describe "Teacher_calendar", type: :request do
  # describe "POST /teacher_calendars/:id" do
  #   before do
  #     @student1 = create_user
  #     @student2 = create_user
  #     @user1 = create_user
  #     @user2 = create_user
  #     @teacher1 = Teacher.create(:user => @user1)
  #     @teacher2 = Teacher.create(:user => @user2)
  #     @avaiablesection=AvailableSection.create(:start => '2016-01-01 00:00:00'.to_time,
  #                                              :end => '2016-01-01 06:00:00'.to_time,
  #                                              :teacher => @teacher1)
  #     Appointment.create(:teacher => @teacher1,
  #                        :user => @student2,
  #                        :start => '2016-01-01 03:30:00'.to_time,
  #                        :end => '2016-01-01 04:30:00'.to_time)
  #     @user_available_section = UserAvailableSection.create!(:user => @student1,
  #                                                            :teacher => @teacher1,
  #                                                            :available_section => 2)
  #   end
  #   it 'should return empty json' do
  #     get "/teacher_calendars/#{@teacher1.id}", :date => '2016-01-01'
  #     data = [{"start" => '2016-01-01 00:00:00 +0800'.to_time, "end" => '2016-01-01 01:00:00 +0800'.to_time, "teacher_id" => 3.to_s, "status" => true},
  #             {"start" => '2016-01-01 00:30:00 +0800'.to_time, "end" => '2016-01-01 01:30:00 +0800'.to_time, "teacher_id" => 3.to_s, "status" => true},
  #             {"start" => '2016-01-01 01:00:00 +0800'.to_time, "end" => '2016-01-01 02:00:00 +0800'.to_time, "teacher_id" => 3.to_s, "status" => true},
  #             {"start" => '2016-01-01 01:30:00 +0800'.to_time, "end" => '2016-01-01 02:30:00 +0800'.to_time, "teacher_id" => 3.to_s, "status" => true},
  #             {"start" => '2016-01-01 02:00:00 +0800'.to_time, "end" => '2016-01-01 03:00:00 +0800'.to_time, "teacher_id" => 3.to_s, "status" => true},
  #             {"start" => '2016-01-01 02:30:00 +0800'.to_time, "end" => '2016-01-01 03:30:00 +0800'.to_time, "teacher_id" => 3.to_s, "status" => true},
  #             {"start" => '2016-01-01 03:00:00 +0800'.to_time, "end" => '2016-01-01 04:00:00 +0800'.to_time, "teacher_id" => 3.to_s, "status" => false},
  #             {"start" => '2016-01-01 03:30:00 +0800'.to_time, "end" => '2016-01-01 04:30:00 +0800'.to_time, "teacher_id" => 3.to_s, "status" => false},
  #             {"start" => '2016-01-01 04:00:00 +0800'.to_time, "end" => '2016-01-01 05:00:00 +0800'.to_time, "teacher_id" => 3.to_s, "status" => false},
  #             {"start" => '2016-01-01 04:30:00 +0800'.to_time, "end" => '2016-01-01 05:30:00 +0800'.to_time, "teacher_id" => 3.to_s, "status" => true},
  #             {"start" => '2016-01-01 05:00:00 +0800'.to_time, "end" => '2016-01-01 06:00:00 +0800'.to_time, "teacher_id" => 3.to_s, "status" => true}]
  #     expect(response.body).to eq(data.to_json)
  #   end
  # end
end