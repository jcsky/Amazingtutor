require 'rails_helper'

#
# describe TeacherCalendarsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AvailableSection, type: :model do
  describe 'time shif' do
    it 'should return half an hour when time < 30 and params is after' do
      time_spec = AvailableSection.time_shif_to_half_an_hour('2016-01-01 00:01:00', 'after')
      expect(time_spec).to eq('2016-01-01 00:30:00'.to_time)
    end
    it 'should return an hour when time < 30 and params is before' do
      time_spec = AvailableSection.time_shif_to_half_an_hour('2016-01-01 00:01:00', 'before')
      expect(time_spec).to eq('2016-01-01 00:00:00'.to_time)
    end
    it 'should return half an hour when time eq 30 and params both after and before' do
      time_spec_before = AvailableSection.time_shif_to_half_an_hour('2016-01-01 00:30:00', 'before')
      expect(time_spec_before).to eq('2016-01-01 00:30:00'.to_time)
      time_spec_after = AvailableSection.time_shif_to_half_an_hour('2016-01-01 00:30:00', 'after')
      expect(time_spec_after).to eq('2016-01-01 00:30:00'.to_time)
    end
    it 'should return  an hour when time > 30 and params is after' do
      time_spec = AvailableSection.time_shif_to_half_an_hour('2016-01-01 00:31:00', 'after')
      expect(time_spec).to eq('2016-01-01 01:00:00'.to_time)
    end
    it 'should return an hour when time > 30 and params is before' do
      time_spec = AvailableSection.time_shif_to_half_an_hour('2016-01-01 00:31:00', 'before')
      expect(time_spec).to eq('2016-01-01 00:30:00'.to_time)
    end
    it 'should return an hour when time is an hour and params both after and before' do
      time_spec_before = AvailableSection.time_shif_to_half_an_hour('2016-01-01 00:00:00', 'before')
      expect(time_spec_before).to eq('2016-01-01 00:00:00'.to_time)
      time_spec_after = AvailableSection.time_shif_to_half_an_hour('2016-01-01 00:00:00', 'after')
      expect(time_spec_after).to eq('2016-01-01 00:00:00'.to_time)
    end
  end

  # describe 'available section bluk insert' do
  #   before do
  #     @user = User.create!(:email => Faker::Internet.email,
  #                          :password => 'qwer4321')
  #   end
  #   it 'should insert 00:00~04:00 eight row to database when database is empty' do
  #     AvailableSection.check_section_insertalbe_and_bluk_insert('2016-01-01 00:00:00', '2016-01-01 04:00:00', @user.id)
  #     sections = AvailableSection.where(:teacher_id => @user)
  #     expect(sections.count).to eq(8)
  #   end
  #   it 'should insert 00:00~04:00 eight row when two row repeat' do
  #     AvailableSection.create(:start => '2016-01-01 01:00:00'.to_time,
  #                             :end => '2016-01-01 01:30:00'.to_time,
  #                             :teacher_id => @user.id)
  #     AvailableSection.create(:start => '2016-01-01 01:30:00'.to_time,
  #                             :end => '2016-01-01 02:00:00'.to_time,
  #                             :teacher_id => @user.id)
  #     AvailableSection.check_section_insertalbe_and_bluk_insert('2016-01-01 00:00:00', '2016-01-01 04:00:00', @user.id)
  #     sections = AvailableSection.where(:teacher_id => @user)
  #     expect(sections.count).to eq(8)
  #   end
  # end
  describe 'available section insert and clean include row' do
    before do
      @user = create_user
      @section1=AvailableSection.create(:start => '2016-01-01 00:00:00'.to_time,
                                        :end => '2016-01-01 01:30:00'.to_time,
                                        :teacher_id => @user.id)
      @section2=AvailableSection.create(:start => '2016-01-01 04:30:00'.to_time,
                                        :end => '2016-01-01 05:30:00'.to_time,
                                        :teacher_id => @user.id)
    end
    it 'should insert and clean one row' do
      AvailableSection.check_section_insertalbe_and_bluk_insert('2016-01-01 00:00:00'.to_time, '2016-01-01 03:00:00'.to_time, @user.id)
      check_section1 = AvailableSection.where('id = ?', @section1.id)
      expect(check_section1.count).to eq(0)
      check_section2 = AvailableSection.where('id = ?', @section2.id)
      expect(check_section2.count).to eq(1)
      inset_section = AvailableSection.last
      expect(inset_section.start).to eq('2016-01-01 00:00:00'.to_time)
      expect(inset_section.end).to eq('2016-01-01 03:00:00'.to_time)
      expect(inset_section.teacher_id).to eq(@user.id)
    end
    it 'should insert and clean two row' do
      AvailableSection.check_section_insertalbe_and_bluk_insert('2016-01-01 00:00:00'.to_time, '2016-01-01 07:00:00'.to_time, @user.id)
      check_section1 = AvailableSection.where('id = ?', @section1.id)
      expect(check_section1.count).to eq(0)
      check_section2 = AvailableSection.where('id = ?', @section2.id)
      expect(check_section2.count).to eq(0)
      inset_section = AvailableSection.last
      expect(inset_section.start).to eq('2016-01-01 00:00:00'.to_time)
      expect(inset_section.end).to eq('2016-01-01 07:00:00'.to_time)
      expect(inset_section.teacher_id).to eq(@user.id)
    end
    it 'should insert and clean any row' do
      AvailableSection.check_section_insertalbe_and_bluk_insert('2016-01-01 05:30:00'.to_time, '2016-01-01 07:00:00'.to_time, @user.id)
      check_section1 = AvailableSection.where('id = ?', @section1.id)
      expect(check_section1.count).to eq(1)
      check_section2 = AvailableSection.where('id = ?', @section2.id)
      expect(check_section2.count).to eq(1)
      inset_section = AvailableSection.last
      expect(inset_section.start).to eq('2016-01-01 05:30:00'.to_time)
      expect(inset_section.end).to eq('2016-01-01 07:00:00'.to_time)
      expect(inset_section.teacher_id).to eq(@user.id)
    end
  end

  describe 'time shif when database exist' do
    before do
      @user = create_user
      AvailableSection.create(:start => '2016-01-01 00:00:00'.to_time,
                              :end => '2016-01-01 01:30:00'.to_time,
                              :teacher_id => @user.id)
      AvailableSection.create(:start => '2016-01-01 04:30:00'.to_time,
                              :end => '2016-01-01 05:30:00'.to_time,
                              :teacher_id => @user.id)
    end
    it 'should return orginal time when it not include any row' do
      shif_time = AvailableSection.time_shif_when_database_exist('2016-01-01 02:00:00'.to_time, @user.id, 'after')
      expect(shif_time).to eq('2016-01-01 02:00:00'.to_time)
    end
    it 'should return end time when it include a row and params is after' do
      shif_time = AvailableSection.time_shif_when_database_exist('2016-01-01 01:00:00'.to_time, @user.id, 'after')
      expect(shif_time).to eq('2016-01-01 01:30:00'.to_time)
    end
    it 'should return end time when it include a row and params is before' do
      shif_time = AvailableSection.time_shif_when_database_exist('2016-01-01 01:00:00'.to_time, @user.id, 'before')
      expect(shif_time).to eq('2016-01-01 00:00:00'.to_time)
    end
  end

  describe 'avaiable_section_check spec' do
    before do
      @student = create_user
      @teacher1 = create_user
      @teacher2 = create_user
      AvailableSection.create(:start => '2016-01-01 00:00:00'.to_time,
                              :end => '2016-01-01 06:00:00'.to_time,
                              :teacher_id => @teacher1.id)
    end
    it 'should retun true when it can avaiable' do
      avaiable_section_check = AvailableSection.avaiable_section_check('2016-01-01 01:00:00'.to_time,
                                                                       '2016-01-01 02:00:00'.to_time,
                                                                       @teacher1.id)
      expect(avaiable_section_check).to eq(true)
    end
    it 'should retun fails when it can not avaiable' do
      avaiable_section_check = AvailableSection.avaiable_section_check('2015-12-31 23:00:00'.to_time,
                                                                       '2016-01-01 02:00:00'.to_time,
                                                                       @teacher1.id)
      expect(avaiable_section_check).to eq(false)
    end
    it 'should retun fails when it can not avaiable type 2' do
      avaiable_section_check = AvailableSection.avaiable_section_check('2016-01-01 05:00:00'.to_time,
                                                                       '2016-01-01 07:00:00'.to_time,
                                                                       @teacher1.id)
      expect(avaiable_section_check).to eq(false)
    end
  end
  describe 'get reservation list' do
    before do
      @student1 = create_user
      @student2 = create_user
      @teacher1 = create_user
      @teacher2 = create_user
      AvailableSection.create(:start => '2016-01-01 00:00:00'.to_time,
                              :end => '2016-01-01 06:00:00'.to_time,
                              :teacher_id => @teacher1.id)
      AvailableSection.create(:start => '2016-01-01 17:00:00'.to_time,
                              :end => '2016-01-01 22:00:00'.to_time,
                              :teacher_id => @teacher1.id)
      Appointment.create(:teacher_id => @teacher1.id,
                         :student_id => @student2.id,
                         :start => '2016-01-01 03:30:00'.to_time,
                         :end =>'2016-01-01 04:30:00'.to_time)
    end
    it 'should return all section by first start time' do
      reservation_list = AvailableSection.query_reservation_time_list_by_date(@teacher1.id,'2016-01-01'.to_time, 2)
      expect(reservation_list.count).to eq(11)
      expect(reservation_list.map{|n| n['status']}.select{ |x| !x }.size).to eq(2)

      reservation_list = AvailableSection.query_reservation_time_list_by_date(@teacher1.id,'2016-01-01'.to_time, 1)
      expect(reservation_list.count).to eq(22)
      expect(reservation_list.map{|n| n['status']}.select{ |x| !x }.size).to eq(2)

      reservation_list = AvailableSection.query_reservation_time_list_by_date(@teacher1.id,'2016-01-02'.to_time, 1)
      expect(reservation_list.count).to eq(0)
      expect(reservation_list.map{|n| n['status']}.select{ |x| !x }.size).to eq(0)
    end
  end
end