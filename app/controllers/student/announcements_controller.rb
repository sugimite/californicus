class Student::AnnouncementsController < Student::Base
  def index
    student = current_student
    today = Date.today

    # 生徒に関連するアナウンスメントと全体公開のアナウンスメントを取得
    @announcements = Announcement.left_joins(:announcement_students)
                                 .where("announcement_students.student_id = ? OR announcement_students.id IS NULL", student.id)
                                 .where("announcements.end_date IS NULL OR announcements.end_date >= ?", today)
                                 .distinct
  end

  def show
    @announcement = Announcement.find(params[:id])
  end
end
