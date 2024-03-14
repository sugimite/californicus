students = Student.all
subject_types = [ "英語", "数学", "国語", "社会", "理科" ]
test_types = [ "1学期中間", "1学期期末", "2学期中間", "2学期期末", "学年末", "実力1", "実力2", "実力3", "実力4", "実力5"]
years = [ 2024, 2023, 2022 ]

150.times do |n|

  Grade.create!(
    student: students.sample,
    year: years[n % 3],
    score: [*1..100].sample,
    subject_type: subject_types[n % 5],
    test_type: test_types[n % 10]
  )
end