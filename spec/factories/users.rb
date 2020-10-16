FactoryBot.define do
  factory :administrator, class: User do
    name { 'factory_name1' }
    email { 'admin@example.com' }
    password { 'password' }
    admin { true }
  end
  factory :user, class: User do
    name { 'factory_name2' }
    email { 'user@example.com' }
    password { 'password' }
    admin { false }
  end
end
