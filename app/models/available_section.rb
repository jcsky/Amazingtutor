class AvailableSection < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :appointment

  # 執行時間移動 預設是after 也就是當時間大於不再整點的時候把時間往下一半點鐘移動
  # 但在結束時間可以使用before指令把時間往前挪動
  def self.time_shif_to_half_an_hour(chosetime, action='after')
    chosetime = chosetime.to_time
    if chosetime == chosetime.at_beginning_of_hour or chosetime == chosetime.at_beginning_of_hour + 30.minute
      # 檢查是不是跟這個小時的初始時間一樣 一樣的話什麼事情都不用做

    elsif chosetime <= chosetime.at_beginning_of_hour + 30.minute
      # 檢查是不是介於0~30分 如果是的話把時間移到30分
      if action =='after'
        chosetime = chosetime.at_beginning_of_hour + 30.minute
      elsif action =='before'
        chosetime = chosetime.at_beginning_of_hour
      end
    else
      # 剩下的時間都是大於30分 把時間移到下一個整點
      if action =='after'
        chosetime = chosetime.at_beginning_of_hour + 1.hour
      elsif action =='before'
        chosetime = chosetime.at_beginning_of_hour + 30.minute
      end
    end
    chosetime
  end

  # def self.check_section_insertalbe_and_bluk_insert(start_time, end_time , teacher_id)
  #   end_time = end_time.to_time
  #   start_time = start_time.to_time
  #   z = (end_time - start_time) / 30.minute
  #   section_attr = Array.new
  #   temp_time = start_time
  #   (1..z).each do |n|
  #     section_attr.push({:start => temp_time, :end => temp_time + 30.minute, :teacher_id => teacher_id})
  #     temp_time += 30.minute
  #   end
  #   return_insert_sections = Array.new
  #   section_attr.each do |attr|
  #     if AvailableSection.where(attr).count==0
  #       return_insert_sections << AvailableSection.create(attr)
  #     end
  #   end
  #   return_insert_sections
  # end

  def self.check_section_insertalbe_and_bluk_insert(start_time, end_time, teacher_id)
    end_time = end_time.to_time
    start_time = start_time.to_time
    check_exist = AvailableSection.where("(start between ? and ?) AND (end between ? and ?) AND teacher_id = ?", start_time, end_time, start_time, end_time, teacher_id)
    check_exist.delete_all
    AvailableSection.create(:start => start_time, :end => end_time, :teacher_id => teacher_id)
  end

  def self.time_shif_when_database_exist(check_time, teacher_id, action)
    check_exist = AvailableSection.where("start < ? AND end > ? AND teacher_id = ?", check_time, check_time, teacher_id)
    if check_exist.count ==1 and action=='after'
      check_time =check_exist.first.end
    elsif check_exist.count ==1 and action=='before'
      check_time =check_exist.first.start
    end
    check_time
  end

  def self.avaiable_section_check(start_time, end_time, teacher_id)
    AvailableSection.where('start <= ? AND end >= ? AND teacher_id = ?',
                           start_time,
                           end_time,
                           teacher_id).exists?
  end

  def self.query_reservation_time_list_by_date(teacher_id, date, section = 2)
    reservation_list = []
    AvailableSection.where('teacher_id = ? and start >= ? and end <= ?',
                           teacher_id,
                           date.to_time.at_beginning_of_day,
                           date.to_time.at_end_of_day).order('start').each do |a|
      start_time = a.start.to_time
      while start_time < a.end.to_time-(30.minute)*(section.to_i-1)  do
        end_time = start_time + (30.minute)*section.to_i
        if !Appointment.appointment_check(start_time, end_time, teacher_id)
          reservation_list << {'start' => start_time, 'end' => end_time, 'teacher_id' => teacher_id, 'status' => true}
        else
          reservation_list << {'start' => start_time, 'end' => end_time, 'teacher_id' => teacher_id, 'status' => false}
        end
        start_time = start_time + (30.minute)
      end
    end
    reservation_list
  end
end
