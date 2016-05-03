require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @student1 = create_user
    @teacher1 = create_user
    @teacher2 = create_user
    Teacher.create(:user_id => @teacher1.id)
  end

end
