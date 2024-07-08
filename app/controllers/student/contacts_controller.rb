class Student::ContactsController < Student::Base
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(student_contact_params)
    @contact.student = current_student
    
    if @contact.valid?
      render action: "confirm"
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: "new"
    end
  end

  private def student_contact_params
    params.require(:contact).permit(:title, :messages)
  end
end
