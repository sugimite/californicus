class Admin::AttendancesController < Admin::Base
  def index
    if params[:student_id]
      @student = Student.find(params[:student_id])
      @attendances = @student.attendances.order(attended_date: :desc)
    else
      @attendances = Attendance.order(attended_date: :desc).includes(:student)
    end
  end 

  def new
    @student = Student.find(params[:student_id])
    @attendance = current_administrator.attendances.new
  end

  def edit
    @student = Student.find(params[:student_id])
    @attendance = Attendance.find(params[:id])
  end

  def create
    @student = Student.find(params[:student_id])
    @attendance = @student.attendances.new(attendances_params)
    
    if @attendance.save
      flash.notice = "出席を記録しました。"
      redirect_to :admin_attendances
    else
      flash.now[:alert] = @attendance.errors.full_messages.join(", ")
      render action: "new", status: :unprocessable_entity
    end

  end

  def update
    @attendance = Attendance.find(params[:id])
    @attendance.assign_attributes(attendances_params)

    if @attendance.save
      flash.notice = "修正を完了しました。"
      redirect_to :admin_attendances
    else
      render action: "edit", status: :unprocessable_entity
    end
  end

  def destroy
    attendance = Attendance.find(params[:id])
    attendance.destroy!
    flash.notice = "出欠を削除しました。"
    redirect_to :admin_attendances
  end

  private

def attendances_params
  params.require(:attendance).permit(:administrator_id, :student_id, :attended_date, :in_at, :out_at, :is_with_no_phone)
end

end
