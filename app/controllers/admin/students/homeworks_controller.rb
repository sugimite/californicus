class Admin::Students::HomeworksController < Admin::Students::Base
  def index
    @student = Student.find(params[:student_id])
    @homeworks = @student.homeworks.order(assigned_date: :desc).includes(:administrator)
  end

  def new
    @student = Student.find(params[:student_id])
    @homework = current_administrator.homeworks.new
  end

  def edit
    @student = Student.find(params[:student_id])
    @homework = @student.homeworks.find(params[:id])
  end

  def create
    @student = Student.find(params[:student_id])
    @homework = @student.homeworks.new(homework_params)
    if @homework.save
      flash.notice = "宿題を課しました。"
      redirect_to :admin_homeworks
    else
      flash.now[:alert] = @homework.errors.full_messages.join(", ")
      render action: "new", status: :unprocessable_entity
    end
  end

  def update
    @homework = Homework.find(params[:id])
    @homework.assign_attributes(homework_params)

    if @homework.save
      flash.notice = "修正を完了しました。"
      redirect_to :admin_homeworks
    else
      render action: "edit", status: :unprocessable_entity
    end
  end

  def destroy
    homework = Homework.find(params[:id])
    homework.destroy!
    flash.notice = "宿題を削除しました。"
    redirect_to :admin_homeworks
  end

  private

  def homework_params
    params.require(:homework).permit(:administrator_id, :student_id, :homework_type, :assigned_date, :deadline, :page, :is_submitted)
  end

end
