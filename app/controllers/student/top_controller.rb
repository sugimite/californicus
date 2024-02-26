class Student::TopController < Student::Base
  def index

    if current_student
      render action: "dashboard"
    else
      render action: "index"
    end
    
  end
end
