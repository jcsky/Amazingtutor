module UsersHelper
  def smallpic
    unless current_user.image_file_name.nil?
      image_tag(current_user.image.url(:medium))
    end
  end
end
