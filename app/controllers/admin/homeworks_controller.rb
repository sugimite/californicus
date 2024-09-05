class Admin::HomeworksController < Admin::Base
  def index
    @homeworks = Homework.includes(:student, :administrator).where(is_submitted: false).order(assigned_date: :desc)
    @homeworks = @homeworks.page(params[:page])
  end
end
