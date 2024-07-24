class Admin::ContactsController < Admin::Base
  def index
    @contacts = Contact.order(date: :desc).includes(:student)
  end

  def destroy_all_by_student
    student = Student.find(params[:student_id])
    student.contacts.destroy_all
    flash.notice = "全てのメッセージが削除されました。"
  end
end
