FactoryBot.define do
  factory :testtask, class: Task do
    title { 'factory_title1' }
    content { 'factory_content1' }
  end
  factory :testtask_second, class: Task do
    title { 'factory_title2' }
    content { 'factory_content2' }
  end
end
