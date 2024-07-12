class Student::ContactsController < Student::Base
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(student_contact_params)
    @contact.student = current_student

    if @contact.valid?
      respond_to do | format |
        format.html { render :confirm }
        format.turbo_stream { render :confirm }
      end
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: "new"
    end
  end

  def create
    @contact = Contact.new(student_contact_params)
    @contact.date ||= DateTime.now

    if params[:commit]
      @contact.student = current_student

      if @contact.save
        flash.notice = "問い合わせを送信しました。"
        redirect_to :student_root
      else
        flash.now.alert = "入力に誤りがあります。"
        render action: "new"
      end
    elsif params[:correct] == "訂正"
      flash.now.notice = "訂正してください。"
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render :new }
      end
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.turbo_stream { render action: "new" }
      end
    end
  end

  private def student_contact_params
    params.require(:contact).permit(:title, :messages, :date, :contact_id)
  end
end
