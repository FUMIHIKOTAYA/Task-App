class Label < ApplicationRecord
  validates :label_name, presence: true, length: { maximum:50 }
  
  has_many :tasks, through: :task_labels
  has_many :task_labels, dependent: :destroy
  belongs_to :user
end
