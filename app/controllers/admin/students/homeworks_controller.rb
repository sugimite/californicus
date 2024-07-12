class Admin::Students::HomeworksController < Admin::Students::Base
  def index
    @homeworks = @student.homeworks.order(assigned_date: :desc).includes(:administrator)
  end

  def new
    @homework = @student.homeworks.new(administrator: current_administrator)
  end

  def edit
    @homework = @student.homeworks.find(params[:id])
  end

  def create
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
    @homework = @student.homeworks.find(params[:id])
    @homework.assign_attributes(homework_params)

    if @homework.save
      flash.notice = "修正を完了しました。"
      redirect_to :admin_homeworks
    else
      render action: "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @student.homeworks.find(params[:id]).destroy!
    flash.notice = "宿題を削除しました。"
    redirect_to :admin_homeworks
  end

  private

  def homework_params
    params.require(:homework).permit(:administrator_id, :student_id, :homework_type, :assigned_date, :deadline, :page, :is_submitted)
  end
end
