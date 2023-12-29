class Admin::SessionsController < Admin::Base
  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = flash.present? ? Admin::LoginForm.new(flash[:admin_params]) : Admin::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Admin::LoginForm.new(login_form_params)
    if @form.code.present?
      administrator =
        Administrator.find_by(code: @form.code)
    end
    if Admin::Authenticator.new(administrator).authenticate(@form.password)
      session[:administrator_id] = administrator.id
      flash.notice = "ログインしました。"
      redirect_to :admin_root
    else
      flash.alert = "IDまたはパスワードが正しくありません。"
      flash[:admin_params] = @form
      redirect_to :admin_login
    end
  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = "ログアウトしました。"
    redirect_to :admin_login
  end

  def login_form_params
    params.require(:admin_login_form).permit(:code, :password)
  end
  
end
