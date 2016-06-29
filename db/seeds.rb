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
Division.create!(id: 1, descrition: "task 1")
Position.create!(id: 1, position: "member")
Position.create!(id: 2, position: "manager")

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
