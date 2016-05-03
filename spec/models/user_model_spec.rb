require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @student = create_user
    @teacher1 = create_user
    @teacher2 = create_user
    Teacher.create(:user_id => @teacher1)
  end
  it 'should retrn false when it is not a teacher' do
    # expect(@student1.teacher).to eq(false)
  end
end
