require 'rails_helper'
RSpec.describe Appointment, type: :model do
  before do
    @student1 = create_user
    @student2 = create_user
    @teacher1 = create_user
    @teacher2 = create_user
    Appointment.create(:teacher_id => @teacher1.id,
                       :student_id => @student2.id,
                       :start => '2016-01-01 03:30:00'.to_time,
                       :end =>'2016-01-01 04:30:00'.to_time)
  end
  describe 'appointment_check spec' do
    it 'should return true when time cross a exist appoiment' do
      appointment_check = Appointment.appointment_check('2016-01-01 03:30:00'.to_time,'2016-01-01 04:30:00'.to_time,@teacher1.id)
      expect(appointment_check).to eq(true)
      appointment_check = Appointment.appointment_check('2016-01-01 02:30:00'.to_time,'2016-01-01 05:30:00'.to_time,@teacher1.id)
      expect(appointment_check).to eq(true)
      appointment_check = Appointment.appointment_check('2016-01-01 02:30:00'.to_time,'2016-01-01 04:00:00'.to_time,@teacher1.id)
      expect(appointment_check).to eq(true)
      appointment_check = Appointment.appointment_check('2016-01-01 04:00:00'.to_time,'2016-01-01 06:00:00'.to_time,@teacher1.id)
      expect(appointment_check).to eq(true)
      appointment_check = Appointment.appointment_check('2016-01-01 03:30:00'.to_time,'2016-01-01 04:00:00'.to_time,@teacher1.id)
      expect(appointment_check).to eq(true)
    end
    it 'should return false when time not touch a exist appoiment' do
      appointment_check = Appointment.appointment_check('2016-01-01 01:30:00'.to_time,'2016-01-01 02:30:00'.to_time,@teacher1.id)
      expect(appointment_check).to eq(false)
      appointment_check = Appointment.appointment_check('2016-01-01 01:30:00'.to_time,'2016-01-01 03:30:00'.to_time,@teacher1.id)
      expect(appointment_check).to eq(false)
    end
    it 'should return false when time not touch a end side exist appoiment' do
      appointment_check = Appointment.appointment_check('2016-01-01 04:30:00'.to_time,'2016-01-01 05:30:00'.to_time,@teacher1.id)
      expect(appointment_check).to eq(false)
      appointment_check = Appointment.appointment_check('2016-01-01 05:30:00'.to_time,'2016-01-01 06:30:00'.to_time,@teacher1.id)
      expect(appointment_check).to eq(false)
    end
    it 'should return true when time inside exist appoiment' do
      appointment_check = Appointment.appointment_check('2016-01-01 03:45:00'.to_time,'2016-01-01 04:15:00'.to_time,@teacher1.id)
      expect(appointment_check).to eq(true)
    end
  end
  describe 'appointment create spec' do
    it 'should create in database' do
      appointment = Appointment.create_appointment('2016-01-01 01:30:00'.to_time,'2016-01-01 02:30:00'.to_time,@teacher1.id , @student1)
      expect(appointment).to eq(Appointment.last)
    end
  end
end