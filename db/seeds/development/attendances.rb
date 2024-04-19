require 'faker'

students = Student.all
administrators = Administrator.all

150.times do |n|
  student = students.sample
  administrator = administrators.sample
  attended_datetime = Faker::Time.between(from: DateTime.new(2024, 4, 1, 0, 0, 0), to: DateTime.now)
  in_at = attended_datetime
  out_at = attended_datetime + rand(1..6).hours

  # 滞在時間を秒単位で計算
  staying_time_seconds = (out_at - in_at).to_i
  # 秒単位の滞在時間を時間と分に変換
  staying_time_hours = staying_time_seconds / 3600
  staying_time_minutes = (staying_time_seconds % 3600) / 60
  staying_time = "#{staying_time_hours}時間 #{staying_time_minutes}分"

  Attendance.create!(
    administrator: administrator,
    student: student,
    attended_date: attended_datetime.to_date,
    in_at: in_at,
    out_at: out_at,
    # 滞在時間を適切なフォーマットで設定
    staying_time: staying_time,
    is_with_no_phone: [true, false].sample
  )
end
