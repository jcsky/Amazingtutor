require 'rails_helper'
RSpec.describe UserAvailableSection, type: :model do
  before do
      @student = create_user
      @teacher1 = create_user
      @teacher2 = create_user
      @user_available_section = UserAvailableSection.create!(:user_id => @student.id,
                                                             :teacher_id => @teacher1.id,
                                                             :available_section => 10)
  end
  describe 'check update credit' do
    it 'should return plus 2 available section' do
      UserAvailableSection.update_credit(@user_available_section, 2, 'plus')
      @user_available_section.reload
      expect(@user_available_section[:available_section]).to eq(12)
    end
    it 'should return less 2 available section' do
      UserAvailableSection.update_credit(@user_available_section, 2, 'less')
      @user_available_section.reload
      expect(@user_available_section[:available_section]).to eq(8)
    end
  end
  describe 'query credit' do
    it 'should return 10 when student has credit' do
      credit = UserAvailableSection.query_credit(@teacher1.id , @student)
      expect(credit.available_section).to eq(10)
    end
    it 'should return nil when student no credit' do
      credit = UserAvailableSection.query_credit(@teacher2.id , @student)
      expect(credit).to eq(nil)
    end
  end
  describe 'create_appointment spec' do
    it 'should return a create object' do

    end
  end
end