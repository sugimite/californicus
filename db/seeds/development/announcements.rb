# db/seeds/development/announcements.rb
administrators = Administrator.all
students = Student.all

# データが存在しない場合のエラーチェック
if administrators.empty? || students.empty?
  raise "Administrators or Students data is missing"
end

puts "Creating announcements..."

# アナウンスメントのシードデータ
announcement_data = [
  {
    administrator: administrators.first,
    title: "重要なお知らせ",
    content: "新しい学期が始まります。準備を整えてください。",
    start_date: Date.today,
    end_date: Date.today + 1.month
  },
  {
    administrator: administrators.last,
    title: "夏休みのお知らせ",
    content: "今年の夏休みは7月20日から8月31日までです。",
    start_date: Date.new(2024, 7, 20),
    end_date: Date.new(2024, 8, 31)
  },
  {
    administrator: administrators.first,
    title: "緊急メンテナンスのお知らせ",
    content: "システムの緊急メンテナンスを行います。ご不便をおかけして申し訳ありません。",
    start_date: Date.today,
    end_date: Date.today + 3.days
  }
]

# アナウンスメントを作成
announcements = announcement_data.map do |data|
  Announcement.create!(data)
end
