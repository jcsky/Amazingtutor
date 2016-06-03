module UsersHelper

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
    # byebug
    disable = []
    disable << 1 if user.user_available_sections.where(:teacher_id=> teacher.id).first.trailed == true || user.user_available_sections.where(:teacher_id=> teacher.id).first.nil?
    disable << 2 if user.user_available_sections.where(:teacher_id=> teacher.id).first.nil? || user.user_available_sections.where(:teacher_id=> teacher.id).first.available_section < 2
    disable
  end

  def free_section_create(teacher_id)
    check_section = current_user.user_available_sections.find(teacher_id:teacher_id)
    if teacher_id.trial_fee == 0 && check_section.nil? && check_section.trailed == false

    end
  end
end
