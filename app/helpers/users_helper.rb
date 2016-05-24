module UsersHelper

  def user_headimage(user)
    if user.image?
      image_url = user.image.url(:medium)
    elsif user.fb_pic?
      image_url = user.fb_pic
    elsif user.google_pic?
      image_url = user.google_pic
    elsif
      image_url = "logo.png"
    end
    image_tag image_url
  end
end
