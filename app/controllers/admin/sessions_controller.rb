class Admin::SessionsController < Admin::Base
  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Admin::LoginForm.new(params[:admin_login_form])
    if @form.code.present?
      administrator =
        Administrator.find_by(code: @form.code)
    end
    if administrator
      session[:administrator_id] = administrator.id
      redirect_to :admin_root
    else
      render action: "new"
    end
  end

  def destroy
    session.delete(:administrator_id)
    redirect_to :admin_login
  end
  
end
