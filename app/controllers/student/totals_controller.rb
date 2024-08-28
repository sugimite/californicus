class Student::TotalsController < Student::Base
  def show

    if @student.nil?
      redirect_to student_login_path, alert: "ログインしてください。"
      return
    end

    @student = current_student
    @homeworks = @student.homeworks.where(is_submitted: false)

    current_school_year = @student.current_school_year
    @monthly_total_staying_time = (3..12).to_a.concat((1..2).to_a).map do |month|
      year = month <= 2 ? current_school_year + 1 : current_school_year 
      [month, Attendance.monthly_total_staying_time(@student.id, year, month)]
    end

    total_hours = 0
    total_minutes = 0

    @monthly_total_staying_time.each do |_, staying_time|
      Rails.logger.debug("Processing staying_time: #{staying_time}")
      staying_time.scan(/(\d+)時間\s*(\d*)分/).each do |hours, minutes|
        total_hours += hours.to_i
        total_minutes += minutes.to_i
      end
    end

  # 分を時間に変換
    total_hours += total_minutes / 60
    total_minutes = total_minutes % 60

  # 今年度の累計勉強時間として格納
    @total_staying_time = "#{total_hours}時間 #{total_minutes}分"
    Rails.logger.debug("Total staying time: #{@total_staying_time}")
  end
end
