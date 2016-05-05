class Evaluation < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :evaluatable, :polymorphic => true


  after_save :update_average

  def update_average
    if evaluatable_type == 'User'
      teacher = Teacher.find(evaluated_id)
      average = Evaluation.where(evaluated_id: teacher.id).average("rating")
      teacher.avg_rating = average
      teacher.save!
    end
  end

end