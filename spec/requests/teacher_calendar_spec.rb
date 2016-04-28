require 'rails_helper'

RSpec.describe "Teacher_calendar", type: :request do
  describe "POST /teacher_calendars/:id" do
    before do
      @student1 = create_user
      @student2 = create_user
      @teacher1 = create_user
      @teacher2 = create_user
      @avaiablesection=AvailableSection.create(:start => '2016-01-01 00:00:00'.to_time,
                                               :end => '2016-01-01 06:00:00'.to_time,
                                               :teacher_id => @teacher1.id)
      Appointment.create(:teacher_id => @teacher1.id,
                         :student_id => @student2.id,
                         :start => '2016-01-01 03:30:00'.to_time,
                         :end => '2016-01-01 04:30:00'.to_time)
      @user_available_section = UserAvailableSection.create!(:user_id => @student1.id,
                                                             :teacher_id => @teacher1.id,
                                                             :available_section => 2)
    end
    it 'should return empty json' do
      get "/teacher_calendars/#{@teacher1.id}" , :date => '2016-01-01'
      data = [{"start"=>'2016-01-01 00:00:00 +0800'.to_time, "end"=>'2016-01-01 01:00:00 +0800'.to_time, "teacher_id" => 3.to_s, "status"=>true},
          {"start"=>'2016-01-01 01:00:00 +0800'.to_time, "end"=>'2016-01-01 02:00:00 +0800'.to_time, "teacher_id"=>3.to_s, "status"=>true},
          {"start"=>'2016-01-01 02:00:00 +0800'.to_time, "end"=>'2016-01-01 03:00:00 +0800'.to_time, "teacher_id"=>3.to_s, "status"=>true},
          {"start"=>'2016-01-01 03:00:00 +0800'.to_time, "end"=>'2016-01-01 04:00:00 +0800'.to_time, "teacher_id"=>3.to_s, "status"=>false},
          {"start"=>'2016-01-01 04:00:00 +0800'.to_time, "end"=>'2016-01-01 05:00:00 +0800'.to_time, "teacher_id"=>3.to_s, "status"=>false},
          {"start"=>'2016-01-01 05:00:00 +0800'.to_time, "end"=>'2016-01-01 06:00:00 +0800'.to_time, "teacher_id"=>3.to_s, "status"=>true}]
      expect(response.body).to eq(data.to_json)
    end
  end
end