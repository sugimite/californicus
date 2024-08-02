students = Student.all
announcements = Announcement.all

puts "Creating announcement_students..."

# AnnouncementStudentsのシードデータ
announcements.each do |announcement|
  students.sample(2).each do |student|
    AnnouncementStudent.create!(
      announcement: announcement,
      student: student
    )
  end
end
