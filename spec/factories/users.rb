FactoryBot.define do
  factory :administrator, class: User do
    name { 'factory_name1' }
    email { 'admin@factory.com' }
    password { 'aaaaaa' }
    admin { 'true' }
  end
  factory :user, class: User do
    name { 'factory_name2' }
    email { 'user@factory.com' }
    password { 'bbbbbb' }
    admin { 'false' }
  end
end
