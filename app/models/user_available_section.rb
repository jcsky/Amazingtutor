class UserAvailableSection < ActiveRecord::Base
  belongs_to :user
  belongs_to :teacher
  # has_many :appointment
  def self.query_credit(teacher_id , student)
    UserAvailableSection.where(:user_id => student.id,
                               :teacher_id => teacher_id).first
  end

  def self.update_credit( credit , calc_section , cacl)
    if cacl == 'less'
      available_sections =credit[:available_section] - calc_section
    elsif cacl == 'plus'
      available_sections =credit[:available_section] + calc_section
    end

    credit.update!(:available_section => available_sections)
  end
end
