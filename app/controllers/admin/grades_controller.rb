class Admin::GradesController < Admin::Base
  def index
    if params[:student_id]
      @student = Student.find(params[:student_id])
      @grades = @student.grades.order(year: :desc)
    else
      @grades = Grade.order(year: :desc)
    end
  end

  def new
    @student = Student.find(params[:student_id])
    @grade = Grade.new
  end

  def edit
    @student = Student.find(params[:student_id])
    @grade = Grade.find(params[:id])
  end

  def create
    student = Student.find(params[:student_id])
    student.grades.new(grades_params)
    
    if student.save
      flash.notice = "成績を登録しました。"
      redirect_to :admin_students
    else
      render action: "new", status: :unprocessable_entity
    end

  end

  def update
    grade = Grade.find(params[:id])
    grade.assign_attributes(grades_params)
    
    if grade.save
      flash.notice = "修正を完了しました。"
      redirect_to :admin_students
    else
      render action: "edit", status: :unprocessable_entity
    end

  end

  private def grades_params
    params.require(:grade).permit(
      :student_id, :year, :test_type, :subject_type, :score 
    )
  end

end
