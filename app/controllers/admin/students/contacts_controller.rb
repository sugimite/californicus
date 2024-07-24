class Admin::Students::ContactsController < Admin::Students::Base
  def index
    @contacts = @student.contacts.order(date: :asc)
    @new_contact = Contact.new
  end

  def create
    @contact = current_administrator.contacts.build(contact_params.merge(date: Time.current, is_from_parents: false, student_id: @student.id))

    if @contact.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to contacts_path, notice: 'メッセージが送信されました。' }
      end
    else
      @contacts = @student.contacts.order(date: :asc)
      @new_contact = Contact.new
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    Contact.find(params[:id]).destroy!
    flash.notice = "削除しました。"
  end

  private

  def contact_params
    params.require(:contact).permit(:message, :administrator_id, :student_id, :date, :is_from_parents)
  end
end
