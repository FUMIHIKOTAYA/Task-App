class Task < ApplicationRecord
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  accepts_nested_attributes_for :task_labels, allow_destroy: true

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :status, presence: true
  validates :priority, presence: true

  enum status: {
    waiting: 0,
    working: 1,
    done: 2
  }
  enum priority: {
    low: 0,
    middle: 1,
    high: 2
  }

  scope :search_title, -> (title) { where('title LIKE?', "%#{title}%") }
  scope :search_status, -> (status) { where(status: status) }
  scope :search_label, -> (label) { where(id: TaskLabel.where(label_id: label).pluck(:task_id)) }
  scope :sorted, -> { order(created_at: :DESC) }
  scope :sorted_deadline, -> { order(deadline: :DESC) }
  scope :sorted_priority, -> { order(priority: :DESC) }
end
