Student.create!(
  name: "山田 太郎",
  name_kana: "ヤマダ タロウ",
  birthday: "1990/03/27",
  registration_date: Date.today,
  cancellation_date: nil,
  password: "password",
  email: "taro@example.com"
)

names = ["佐藤", "鈴木", "高橋", "田中"]

names_kana = ["サトウ", "スズキ", "タカハシ", "田中"]

4.times do |n|
  Student.create!(
    name: names[n],
    name_kana: names_kana[n],
    birthday: "1990/04/04",
    registration_date: (100 - n).days.ago.to_date,
    cancellation_date: nil,
    password: "password",
    email: "test@example.com"
  )
end
