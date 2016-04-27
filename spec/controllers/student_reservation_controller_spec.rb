require 'rails_helper'

RSpec.describe StudentReservationController, type: :controller do
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
    sign_in @student1
  end
  describe 'checkavailabel sction' do
    it 'all condition is ok and insert appoiment , update user_available_section' do
      post :create, :start => '2016-01-01 00:00:00',
           :end => '2016-01-01 01:00:00',
           :teacher_id => @teacher1.id
      @user_available_section.reload
      expect(@user_available_section[:available_section]).to eq(0)
      appointment = Appointment.where(:start => '2016-01-01 00:00:00'.to_time,
                                      :end => '2016-01-01 01:00:00'.to_time,
                                      :teacher_id => @teacher1.id,
                                      :student_id => @student1.id)
      expect(appointment.count).to eq(1)
    end
    it 'appoiment exist' do
      post :create, :start => '2016-01-01 03:30:00',
           :end => '2016-01-01 04:30:00',
           :teacher_id => @teacher1.id
      @user_available_section.reload
      expect(@user_available_section[:available_section]).to eq(2)
      appointment = Appointment.where(:start => '2016-01-01 03:30:00'.to_time,
                                      :end => '2016-01-01 04:30:00'.to_time,
                                      :teacher_id => @teacher1.id,
                                      :student_id => @student1.id)
      expect(appointment.count).to eq(0)
    end
    it 'appoiment time touch start side' do
      post :create, :start => '2016-01-01 02:30:00',
           :end => '2016-01-01 03:30:00',
           :teacher_id => @teacher1.id
      @user_available_section.reload
      expect(@user_available_section[:available_section]).to eq(0)
      appointment = Appointment.where(:start => '2016-01-01 02:30:00'.to_time,
                                      :end => '2016-01-01 03:30:00'.to_time,
                                      :teacher_id => @teacher1.id,
                                      :student_id => @student1.id)
      expect(appointment.count).to eq(1)
    end
    it 'appoiment time touch end side' do
      post :create, :start => '2016-01-01 03:35:00',
           :end => '2016-01-01 04:15:00',
           :teacher_id => @teacher1.id
      @user_available_section.reload
      expect(@user_available_section[:available_section]).to eq(2)
      appointment = Appointment.where(:start => '2016-01-01 03:45:00'.to_time,
                                      :end => '2016-01-01 04:15:00'.to_time,
                                      :teacher_id => @teacher1.id,
                                      :student_id => @student1.id)
      expect(appointment.count).to eq(0)
    end
    it 'appoiment time inside' do
      post :create, :start => '2016-01-01 04:30:00',
           :end => '2016-01-01 05:30:00',
           :teacher_id => @teacher1.id
      @user_available_section.reload
      expect(@user_available_section[:available_section]).to eq(0)
      appointment = Appointment.where(:start => '2016-01-01 04:30:00'.to_time,
                                      :end => '2016-01-01 05:30:00'.to_time,
                                      :teacher_id => @teacher1.id,
                                      :student_id => @student1.id)
      expect(appointment.count).to eq(1)
    end
    it 'credit is not enough' do
      post :create, :start => '2016-01-01 01:00:00',
           :end => '2016-01-01 05:00:00',
           :teacher_id => @teacher1.id
      @user_available_section.reload
      expect(@user_available_section[:available_section]).to eq(2)
      appointment = Appointment.where(:start => '2016-01-01 01:00:00'.to_time,
                                      :end => '2016-01-01 05:00:00'.to_time,
                                      :teacher_id => @teacher1.id,
                                      :student_id => @student1.id)
      expect(appointment.count).to eq(0)
    end
  end
end