students = Student.all

150.times do |n|
  Memo.create!(
    administrator: Administrator.first,
    student: students.sample,
    input_date: (100 - n).days.ago.to_date,
    content: "#{n}個目のテストです。これがメモの内容です。よろしくお願いします。"
  )
end
