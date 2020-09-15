FactoryBot.define do
  factory :testtask, class: Task do
    title { 'Faker::Name.first_name' }
    content { 'Faker::Name.name' }
  end
end
