module UsersHelper

  def count_num(available_sections)
    @count_sections = 0
    available_sections.each do |available_section|
      @count_sections += 1 if available_section.available_section % 2 == 1
      @count_sections += (available_section.available_section / 2).to_i
    end
    @count_sections
  end

  def user_headimage(user)
    if user.image?
      image_url = user.image.url(:medium)
    elsif user.fb_pic?
      image_url = user.fb_pic
    elsif user.google_pic?
      image_url = user.google_pic
    else
      image_url = "logo.jpg"
    end
      image_tag image_url
  end

  def trail_check(user,teacher)
    disable_type = []
    disable_type << 1 if  user.user_available_sections.find_by(:teacher_id=> teacher.id).nil? || user.user_available_sections.find_by(:teacher_id=> teacher.id).trailed.nil? || user.user_available_sections.find_by(:teacher_id=> teacher.id).trailed == false
    disable_type << 2 if user.user_available_sections.find_by(:teacher_id=> teacher.id).nil? || user.user_available_sections.find_by(:teacher_id=> teacher.id).available_section < 2
    disable_type
  end

  def free_section_create(teacher_id)
    check_section = current_user.user_available_sections.find(teacher_id:teacher_id)
    if teacher_id.trial_fee == 0 && check_section.nil? && check_section.trailed == false

    end
  end
end
