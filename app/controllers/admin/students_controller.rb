class Admin::StudentsController < Admin::Base
  def index
    @students = Student.order(:name_kana).where(cancellation_date: nil)
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

  def leaving_seat
    Student.find(params[:id]).attendances.find_by!(out_at: nil).update!(out_at: Time.current)
    flash.notice = "離席しました。"
    redirect_to :admin_students
  end

  def taking_seat
    @attendance = Student.find(params[:id]).attendances.new(
      attended_date: Date.today,
      in_at: Time.current,
      out_at: nil,
      administrator_id: current_administrator.id
      )
    flash.notice = "出席しました。" if @attendance.save
    redirect_to :admin_students
  end

  def submit_homework
    Homework.find(params[:homework_id]).update!(is_submitted: true)
    flash.notice = "提出しました。"
    redirect_to :admin_students
  end

  def assign_homeworks
    @student_ids = params[:student_ids]
    
    if @student_ids.nil? 
      redirect_to :admin_students
    end
  end

  def create_homeworks
    @student_ids = params[:student_ids]
    homework_params = params.require(:homework).permit(:homework_type, :page, :assigned_date, :deadline)
  
    @student_ids.each do |id|
      student = Student.find(id)
      homework = student.homeworks.create(homework_params.merge(administrator_id: current_administrator.id))
    end
    
    flash[:notice] = "宿題を課しました。"
    redirect_to admin_students_path
  end
  
  private def students_params
    params.require(:student).permit(
      :name, :name_kana, :email, :password, :birthday, :registration_date, :cancellation_date
    )
  end
end
