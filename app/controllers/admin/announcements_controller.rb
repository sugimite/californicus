class Admin::AnnouncementsController < Admin::Base
  def index
    @announcements = Announcement.order(start_date: :desc)
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

  def new
    @announcement =Announcement.new
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end
end
