User.create!(name: "Nguyen Duy Tuan",
  email: "tuannd@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  admin: true)

50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end

Skill.create!(id: 1, language: "C")
Skill.create!(id: 2, language: "Ruby")
Skill.create!(id: 3, language: "Java")
Division.create!(id: 1, descrition: "task1111:")
Position.create!(id: 1, position: "member")
