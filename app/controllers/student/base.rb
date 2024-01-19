class Student::Base < ApplicationController
  private def current_student
    if session[:student_id]
      @current_student ||=
        Student.find_by(id: session[:student_id])
    end
  end

  helper_method :current_student
end
