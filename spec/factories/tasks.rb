FactoryBot.define do
  factory :testtask, class: Task do
    title { 'タスク１' }
    content { 'タスク１内容' }
  end
end
