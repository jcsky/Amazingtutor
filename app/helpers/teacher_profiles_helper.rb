module TeacherProfilesHelper
  def youtube_website
    if current_user.teacher.youtube
      current_user.teacher.youtube.gsub("watch?v=","embed/")+"?playlist=&version=3&controls=0&fs=0&rel=0&showinfo=0&iv_load_policy=3&theme=light"
    else
      "https://www.youtube.com/embed/z3XVg9wRVmk"
    end
  end
end
