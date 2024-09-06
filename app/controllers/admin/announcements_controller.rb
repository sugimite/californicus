class Admin::AnnouncementsController < Admin::Base
  def index
    @announcements = Announcement.order(start_date: :desc)
    @announcements = @announcements.page(params[:page])
  end  

  def show
    @announcement = Announcement.find(params[:id])
  end

  def new
    @announcement = Announcement.new
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def create
    @announcement = Announcement.new(announcement_params)

    if @announcement.save
      associate_students_with_announcement
      flash.notice = "お知らせを掲載しました。"
      redirect_to :admin_announcements
    else
      render action: "new", status: :unprocessable_entity
    end
  end

  def update
    @announcement = Announcement.find(params[:id])
    @announcement.assign_attributes(announcement_params)

    if @announcement.save
      @announcement.announcement_students.destroy_all
      associate_students_with_announcement
      flash.notice = "お知らせを更新しました。"
      redirect_to :admin_announcements
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Announcement.find(params[:id]).destroy!
    redirect_to :admin_announcements, notice: "お知らせを削除しました。"
  end

  private

  def associate_students_with_announcement
    selected_grades = params[:announcement][:school_grades].reject(&:blank?).map(&:to_i)

    if selected_grades.empty?
      @announcement.announcement_students.clear
    else
      students_to_associate = Student.where(birthday: selected_grades.map { |grade| grade.years.ago.beginning_of_year..grade.years.ago.end_of_year })
      @announcement.announcement_students.create!(students_to_associate.map { |student| { student_id: student.id } })
    end
  end

  def announcement_params
    params.require(:announcement).permit(
      :administrator_id, :title, :content, :start_date, :end_date, :ages
    )
  end
end
