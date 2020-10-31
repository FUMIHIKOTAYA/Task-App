FactoryBot.define do
  factory :testlabel, class: Label do
    label_name { 'factory_label1' }
  end
  factory :testlabel_second, class: Label do
    label_name { 'factory_label2' }
  end
  factory :testlabel_third, class: Label do
    label_name { 'factory_label3' }
    association :user, factory: :administrator
  end
  factory :testlabel_fourth, class: Label do
    label_name { 'factory_label4' }
    association :user, factory: :user
  end
end
