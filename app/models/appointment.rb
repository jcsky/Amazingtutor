class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :teacher
  has_many :evaluations
  has_one :available_section
  # has_one :user_available_section
  def book_section
    [:start, :end].join('~')
  end

  def book_section=(sections)
    split = sections.split('~', 2)
    self.start = split.first.in_time_zone
    self.end = split.last.in_time_zone
  end

  def self.appointment_check(start_time, end_time, teacher_id)
    # 被包含在內 (start => ? and end <= ?)
    # 開始時間在內 (start > ?  and start < ?)
    # 結束時間在內 (end > ?  and end < ?)
    # 整個時段被包含在某一個預約時間內(start < ? and end > ?)
    # Appointment.where("((start between ? and ?) OR (end between ? and ?)) AND teacher_id = ?",
    #                        start_time, end_time,
    #                        start_time, end_time,
    #                        teacher_id).exists?
    Appointment.where("((start >= ? and end <= ?) or (start >= ?  and start < ?) or (end > ?  and end <= ?) or (start < ? and end > ?)) AND teacher_id = ?",
                      start_time, end_time,
                      start_time, end_time,
                      start_time, end_time,
                      start_time, end_time,
                      teacher_id).exists?
  end

  def self.create_appointment(start_time, end_time, teacher, student)
    Appointment.create!(:start => start_time,
                        :end => end_time,
                        :teacher => teacher,
                        :user => student,
                        :section => (end_time - start_time) / 30.minute)
  end
  def self.booked_section(teacher_id)
    where('teacher_id=? and end > ? and start < ?',
          teacher_id,
          Time.now.in_time_zone.at_beginning_of_day,
          14.days.from_now.in_time_zone.at_end_of_day)
  end

  def check_and_destroy!
    if self.start-12.hours< Time.now.in_time_zone
    #   in six hours   donothing
      puts 'can not delete'
    elsif self.start-12.hours > Time.now.in_time_zone
    #   delete it and resume 2 point to user_available_sections
      self.destroy
      puts 'delete'
    else
    #   do nothing
    end
  end
end
