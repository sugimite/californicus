class Student::SessionsController < Student::Base
  def new
    if current_student
      redirect_to :student_root
    else
      @form = Student::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Student::LoginForm.new(login_form_params)
    student = Student.find_by("LOWER(email) = ?", @form.email&.downcase)

    if Student::Authenticator.new(student).authenticate(@form.password)
      session[:student_id] = student.id
      flash.notice = "ログインしました。"
      redirect_to :student_root
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new", status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:student_id)
    flash.notice = "ログアウトしました。"
    redirect_to :student_root
  end

  def login_form_params
    params.require(:student_login_form).permit(:email, :password)
  end
end
