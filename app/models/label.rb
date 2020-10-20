class Label < ApplicationRecord
  validates :label_name, presence: true, length: { maximum:50 }

  has_many :task_labels, dependent: :destroy
  has_many :tasks, through: :task_labels
  belongs_to :user, optional: true
end
