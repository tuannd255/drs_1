User.create!(name: "Nguyen Duy Tuan",
  email: "tuannd@gmail.com",
  password: "123456",
  birthday: "1994-05-25",
  password_confirmation: "123456",
  admin: true,
  profile: Profile.create!(user_id: :id))

Position.create! position: "manager"
Position.create! position: "employee"
Skill.create! language: "c"
Skill.create! language: "java"
Skill.create! language: "php"
Division.create! descrition: "keangnam"

10.times do |n|
  name = Faker::Name.name
  email = "tuannd#{n+1}@gmail.com"
  password = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    profile: Profile.create!(user_id: :id, position_id: Position.second.id))
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
