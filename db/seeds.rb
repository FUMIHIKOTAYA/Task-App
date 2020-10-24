User.create!(
  name: "firstperson",
  email: "first@example.com",
  password: "password",
  password_confirmation: "password",
)

User.create!(
  name: "adminperson",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
)

10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   )
end

task_list = []
10.times do |n|
  task_list <<
    { title: Faker::Book.title,
      content: Faker::Quote.famous_last_words,
      deadline: Faker::Date.between(from: Date.today, to: 3.days.since),
      status: 1,
      priority: 1,
      user_id: User.ids.sample,
    }
end
Task.create!(task_list)

label_list = ["すぐできる","時間かかる","簡単","難しい"]
(1..4).each do |n|
  label = Label.create!(label_name: label_list[n-1])
end
