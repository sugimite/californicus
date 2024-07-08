class Admin::Students::Base < Admin::Base
  before_action :fetch_student

  def fetch_student
    @student = Student.find(params[:student_id])
  end
end
