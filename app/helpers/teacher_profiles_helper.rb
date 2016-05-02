module TeacherProfilesHelper
  def youtube_website
    unless current_user.teacher.youtube.empty?
      current_user.teacher.youtube.gsub("watch?v=","embed/")
    else
      "https://www.youtube.com/embed/z3XVg9wRVmk"
    end
  end
end
