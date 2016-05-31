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
    "1" if user.user_available_sections.where(:teacher_id=> teacher.id).first.trailed == false     
  end
end
