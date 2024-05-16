class Admin::MemosController < Admin::Base
  def index
    @student = Student.find(params[:student_id])
    @memos = @student.memos.order(input_date: :desc).includes(:administrator)
  end

  def show
    @student = Student.find(params[:student_id])
    @memo = Memo.find(params[:id])
  end 

  def new 
    @student = Student.find(params[:student_id])
    @memo = Memo.new
    @default_administrator_id = Administrator.first.id 
  end

  def edit
    @student = Student.find(params[:student_id])
    @memo = Memo.find(params[:id])
    @default_administrator_id = @memo.administrator_id
  end

  def create
    @student = Student.find(params[:student_id])
    @memo = @student.memos.new(memos_params)
    @memo.input_date = Date.current
    
    if @memo.save
      flash.notice = "メモを登録しました。"
      redirect_to :admin_students
    else
      Rails.logger.error("メモの保存に失敗しました: #{@memo.errors.full_messages}")
      render action: "new", status: :unprocessable_entity
    end
  end

  def update
    memo = Memo.find(params[:id])
    memo.assign_attributes(memos_params)

    if memo.save
      flash.notice = "修正を完了しました。"
      redirect_to :admin_students
    else
      render action: "edit", status: :unprocessable_entity
    end
  end

  def destroy
    memo = Memo.find(params[:id])
    memo.destroy!
    flash.notice = "メモを削除しました。"
    redirect_to :admin_students
  end

  def memos_params
    params. require(:memo).permit(
      :student_id, :input_date, :content, :administrator_id
    )
  end
end
