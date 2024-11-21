class Admin::StudentsController < Admin::Base
  def index
    @search_form = Admin::StudentSearchForm.new(search_params)
    @students = @search_form.search(Student.order(birthday: :desc).where(cancellation_date: nil))
    @students = @students.page(params[:page])
  end
 
  def show
    @student = Student.includes(
      :homeworks, 
      :homework_forgets,
      :attendances,
      :absences,
      :memos
    ).find(params[:id])
    @homeworks = @student.homeworks.where(is_submitted: false)
    @homeworks_past = @student.homeworks.group_by(&:assigned_date)
    @homework_forgets_this_year = @student.homework_forgets_in_year(Date.today.year)
    @homeworks_past = @student.homeworks.group_by(&:assigned_date)
    @attendances_and_absences = (
      @student.attendances.map { |attendance| [attendance.attended_date, attendance] } +
      @student.absences.map { |absence| [absence.absent_on, nil] })
      .sort_by { |date, _| date }.reverse
    @memos = @student.memos.group_by(&:input_date)
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
    student = Student.find(params[:id])
    @attendance = student.attendances.new(
      attended_date: Date.today,
      in_at: Time.current,
      out_at: nil,
      administrator_id: current_administrator.id,
      is_with_no_phone: student.has_deposited_phone? 
      )
    flash.notice = "出席しました。" if @attendance.save
    redirect_to :admin_students
  end

  def increase_number
    student = Student.find(params[:id])

    HomeworkForget.create!(
      student_id: student.id,
      count: 1,
      forgetted_on: Date.today
    )
  
    flash[:notice] = "宿題忘れ回数を増やしました。"
    redirect_to admin_students_path
  end

  def decrease_number
    student = Student.find(params[:id])

    last_forget = student.homework_forgets.order(:forgetted_on).last
    if last_forget.present?
      last_forget.destroy!
      flash[:notice] = "宿題忘れ回数を減らしました。"
    else
      flash[:alert] = "宿題忘れの記録がありません。"
    end

    redirect_to admin_students_path
  end

  def increase_number_absence
    student = Student.find(params[:id])

    Absence.create!(
      student_id: student.id,
      count: 1,
      absent_on: Date.today
    )
  
    flash[:notice] = "欠席を記録しました。"
    redirect_to admin_students_path
  end

  def decrease_number_absence
    student = Student.find(params[:id])

    last_absence = student.absences.order(:absent_on).last
    if last_absence.present?
      last_absence.destroy!
      flash[:notice] = "欠席を取り消しました。"
    else
      flash[:alert] = "欠席の記録がありません。"
    end

    redirect_to admin_students_path
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
    error_occured = false 
  
    @student_ids.each do |id|
      student = Student.find(id)
      homework = student.homeworks.create(homework_params.merge(administrator_id: current_administrator.id))

      unless homework.save
        error_occured = true
        break
      end
    end
    
    if error_occured
      flash.now[:alert] = "入力に誤りがあります。"
      @homework = Homework.new(homework_params)
      render action: "assign_homeworks", status: :unprocessable_entity
    else
      flash[:notice] = "宿題を課しました。"
      redirect_to admin_students_path
    end
  end
  
  private def students_params
    params.require(:student).permit(
      :name, :name_kana, :email, :password, :birthday, :registration_date, :cancellation_date, :has_deposited_phone
    )
  end
  
  def search_params
    params.fetch(:search, {}).permit(:name, :school_grade, :name_kana)
  end
end
