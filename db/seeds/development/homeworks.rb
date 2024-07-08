require 'faker'

# 既存の学生と管理者を取得
students = Student.all
administrators = Administrator.all

10.times do
  assigned_date = Faker::Time.between(from: 30.days.ago, to: DateTime.now)
  Homework.create!(
    homework_type: Homework::HOMEWORK_TYPES.sample,
    page: Faker::Number.between(from: 1, to: 100).to_s,
    assigned_date: assigned_date,
    deadline: Faker::Time.between(from: assigned_date + 1.days, to: assigned_date + 14.days),
    is_submitted: Faker::Boolean.boolean,
    student_id: students.sample.id,
    administrator_id: administrators.sample.id
  )
end
