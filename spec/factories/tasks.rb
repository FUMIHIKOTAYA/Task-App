FactoryBot.define do
  factory :testtask, class: Task do
    title { 'factory_title1' }
    content { 'factory_content1' }
    deadline { Time.current }
    status { 2 }
  end
  factory :testtask_second, class: Task do
    title { 'factory_title2' }
    content { 'factory_content2' }
    deadline { Time.current.next_month }
    status { 0 }
  end
  factory :testtask_third, class: Task do
    title { 'factory_title3' }
    content { 'factory_content3' }
    deadline { Time.current.tomorrow }
    status { 1 }
  end
end
