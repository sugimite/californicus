class Student::GradeController < Student::Base
  def show
    @student = current_student
    @grades_by_year = @student.grades.group_by(&:year).sort_by { |year, _| -year }.to_h
  end
end
