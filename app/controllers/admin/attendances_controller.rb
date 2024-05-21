class Admin::AttendancesController < Admin::Base
  def index
    @attendances = Attendance.order(attended_date: :desc).includes(:student)
  end 
  
end
