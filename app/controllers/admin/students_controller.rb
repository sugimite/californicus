class Admin::StudentsController < Admin::Base
  def index
    @students = Student.order(:name_kana)
  end

  def show
    @student = Studnet.find(params[:id])
    redirect_to [ :edit,  :admin, student ]
  end

  def new
    @student = Student.new
  end
end
