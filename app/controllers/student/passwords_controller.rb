class Student::PasswordsController < Student::Base
  def show
    redirect_to :edit_staff_password
  end

  def edit
    @change_password_form =
      Student::ChangePasswordForm.new(object: current_student)
  end

  def update
    @change_password_form = Student::ChangePasswordForm.new(student_params)
    @change_password_form.object = current_student
    if @change_password_form.save
      flash.notice = "パスワードを変更しました。"
      redirect_to :student_account
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: "edit", status: :unprocessable_entity
    end
  end

  private def student_params
    params.require(:student_change_password_form).permit(
      :current_password, :new_password, :new_password_confirmation
    )
  end
end
