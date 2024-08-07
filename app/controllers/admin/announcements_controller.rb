class Admin::AnnouncementsController < Admin::Base
  def index
    @announcements = Announcement.order(start_date: :desc)
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

  private def announcement_params
    params.require(:announcement).permit(
      :administrator_id, :title, :content, :start_date, :end_date 
    )
  end
end
