require 'faker'

# 既存の学生と管理者を取得
students = Student.all
administrators = Administrator.all

# Fakerを使ってシードデータを生成
homeworks_data = 10.times.map do
  assigned_date = Faker::Time.between(from: 30.days.ago, to: DateTime.now)
  deadline = Faker::Time.between(from: assigned_date, to: assigned_date + 14.days)
  {
    homework_type: Homework::HOMEWORK_TYPES.sample,
    page: Faker::Number.between(from: 1, to: 100).to_s,
    assigned_date: assigned_date,
    deadline: deadline,
    is_submitted: Faker::Boolean.boolean,
    student_id: students.sample.id,
    administrator_id: administrators.sample.id
  }
end

# Homeworksテーブルにシードデータを挿入
homeworks_data.each do |homework_data|
  Homework.create!(
    homework_type: homework_data[:homework_type],
    page: homework_data[:page],
    assigned_date: homework_data[:assigned_date],
    deadline: homework_data[:deadline],
    is_submitted: homework_data[:is_submitted],
    student_id: homework_data[:student_id],
    administrator_id: homework_data[:administrator_id]
  )
end

puts "Homework seeding completed!"
