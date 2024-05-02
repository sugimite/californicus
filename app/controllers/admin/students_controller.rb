class Admin::StudentsController < Admin::Base
  def index
    @students = Student.order(:name_kana)
  end

  def new
    @student = Student.new
  end

  def edit
    @student = Student.find(params[:id])
  end

  def create
    @student = Student.new(students_params)

    if @student.save
      flash.notice = "生徒情報を登録しました。"
      redirect_to :admin_students
    else
      render action: "new", status: :unprocessable_entity
    end
  end

  def update
    @student = Student.find(params[:id])

    if @student.update(students_params)
      flash.notice = "生徒情報を更新しました。"
      redirect_to :admin_students
    else
      render action: "edit", status: :unprocessable_entity
    end
  end

  def destroy
    Student.find(params[:id]).destroy!
    redirect_to :admin_students, notice: "生徒情報を削除しました。"
  end

  def toggle_attendance
    @student = Student.find(params[:id])
    attendance = params[:attendance] == "true"
    @student.update(attendance: attendance)
    
    respond_to do |format|
      format.json { render json: { status: :ok } }
    end
  end

  private def students_params
    params.require(:student).permit(
      :name, :name_kana, :email, :password, :birthday, :registration_date, :cancellation_date
    )
  end
end
