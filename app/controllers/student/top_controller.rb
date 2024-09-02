class Student::TopController < Student::Base
  def index
    @unread_contacts_count = Contact.where(read: false).count
    @unread_contacts_count ||= 0

    if current_student
      render action: "dashboard"
    else
      redirect_to student_login_path, alert: "ログインしてください。"
      return
    end
  end
end
