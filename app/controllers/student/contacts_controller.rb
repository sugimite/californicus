class Student::ContactsController < Student::Base
  def index
    @contacts = Contact.all
    @new_contact = Contact.new
  end

def create
  @contact = current_student.contacts.build(contact_params.merge(date: Time.current, is_from_parents: true))
  
  if @contact.save
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.append('contacts', partial: 'student/contacts/contact', locals: { contact: @contact }) }
      format.html { redirect_to contacts_path, notice: 'メッセージが送信されました。' }
    end
  else
    @contacts = Contact.all
    @new_contact = @contact
    @errors = @contact.errors.full_messages if @contact.errors.any?  # エラーがある場合のみエラーメッセージをセットする
    flash.now[:alert] = "メッセージの送信に失敗しました。"
    render :index, status: :unprocessable_entity
  end
end

  
  

  private

  def contact_params
    params.require(:contact).permit(:message, :student_id, :date, :is_from_parents)
  end
end
