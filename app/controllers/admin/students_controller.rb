class Admin::StudentsController < Admin::Base
  def index
    @students = Student.order(:name_kana)
  end

  def show
    @student = Studnet.find(params[:id])
    redirect_to [ :edit, :admin, :student ]
  end

  def new
    @student = Student.new
  end

  def edit
    @student = Student.find(params[:id])
  end

  def create
    @student = Student.new(params[:student])
    if @student.save
      flash.notice = "生徒情報を登録しました。"
      redirect_to :admin_students
    else
      render action: "new"
    end
  end

  end
