codes = ["sugioka", "atarashi"]

codes.each do |code|
Administrator.create!(
  code: code,
  password: "#{code}888"
)
end
