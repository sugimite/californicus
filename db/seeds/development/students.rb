students = [
  {name: "佐藤 太郎", name_kana: "サトウ タロウ"},
  {name: "鈴木 次郎", name_kana: "スズキ ジロウ"},
  {name: "高橋 三郎", name_kana: "タカハシ サブロウ"},
  {name: "田中 四郎", name_kana: "タナカ シロウ"}
]

students.each_with_index do |s, index|
  birthday = [*12..18].sample.years.ago.to_date.advance(days: -[*1..365].sample).to_date
  registration_date = (100 - index).days.ago.to_date
  cancellation_date = index.zero? ? registration_date.advance(months: 1) : nil 

  Student.create!(
    name: s[:name],
    name_kana: s[:name_kana],
    birthday: birthday,
    registration_date: registration_date,
    cancellation_date: cancellation_date,
    password: "password",
    email: "test#{index + 1}@example.com" 
  )
end
