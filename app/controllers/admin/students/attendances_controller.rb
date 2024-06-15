class Admin::Students::AttendancesController < Admin::Students::Base
  def index
    @attendances = @student.attendances.order(attended_date: :desc)
  end

  def new
    @attendance = current_administrator.attendances.new
  end

  def edit
    @attendance = Attendance.find(params[:id])
  end

  def create
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