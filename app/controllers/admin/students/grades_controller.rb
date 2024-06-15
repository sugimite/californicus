class Admin::Students::GradesController < Admin::Students::Base
  def index
      @grades = @student.grades.order(year: :desc)
      @test_results = @grades&.group_by { |result| [result.year, result.test_type] }
  end

  def new
    @grade = Grade.new
  end

  def show
    @grade = Grade.find(params[:id])
  end

  def edit
    @grade = Grade.find(params[:id])
  end

  def create
    student.grades.new(grades_params)
    
    if student.save
      flash.notice = "成績を登録しました。"
      redirect_to :admin_grades
    else
      render action: "new", status: :unprocessable_entity
    end

  end

  def update
    grade = Grade.find(params[:id])
    grade.assign_attributes(grades_params)
    
    if grade.save
      flash.notice = "修正を完了しました。"
      redirect_to :admin_grades
    else
      render action: "edit", status: :unprocessable_entity
    end

  end

  def destroy
    grade = Grade.find(params[:id])
    grade.destroy!
    flash.notice = "成績を削除しました。"
    redirect_to :admin_grades
  end

  private def grades_params
    params.require(:grade).permit(
      :student_id, :year, :test_type, :subject_type, :score 
    )
  end
end