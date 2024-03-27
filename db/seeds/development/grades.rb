students = Student.all
subject_types = Grade::SUBJECT_TYPES
test_types Grade::TEST_TYPES
years = [*(Time.current.year - 2)..Time.current.year].reverse

150.times do |n|
  Grade.create!(
    student: students.sample,
    year: years[n % 3],
    score: [*1..100].sample,
    subject_type: subject_types[n % 5],
    test_type: test_types[n % 10]
  )
end
