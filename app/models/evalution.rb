class Evalution < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :user
  belongs_to :teacher

  after_save :update_average

  def update_average
    sum = 0
    teacher = self.teacher
    count = teacher.evalutions.count
    teacher.evalutions.each do |e|
      value = e.rating
      sum = sum + value
    end
    teacher.avg_rating = (sum/count).to_f
    teacher.save!

  end

end
