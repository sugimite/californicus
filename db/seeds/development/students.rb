names = ["佐藤", "鈴木", "高橋", "田中"]

names_kana = ["サトウ", "スズキ", "タカハシ", "タナカ"]

4.times do |n|
  Student.create!(
    name: names[n],
    name_kana: names_kana[n],
    birthday: "1990/04/04",
    registration_date: (100 - n).days.ago.to_date,
    cancellation_date: nil,
    password: "password",
    email: "test#{n}@example.com"
  )
end
