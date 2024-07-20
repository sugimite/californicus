class Student::Base < ApplicationController
before_action :set_student

  private
  
  def set_student
    @student = current_student
  end

  def current_student
    if session[:student_id]
      @current_student ||=
        Student.find_by(id: session[:student_id])
    end
  end

  helper_method :current_student
end
