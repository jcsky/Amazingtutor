module TeacherProfilesHelper
  def youtube_website
    if current_user.teacher.youtube.blank?
      "https://www.youtube.com/embed/z3XVg9wRVmk"
    else
        current_user.teacher.youtube.gsub("watch?v=","embed/")
    end
  end
end
