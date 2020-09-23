class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :status, presence: true

  enum status: {
    waiting: 0,
    working: 1,
    done: 2
  }

  scope :search_title, -> (title) { where('title LIKE?', "%#{title}%") }
  scope :search_status, -> (status) { where(status: status) }
  scope :sorted, -> { order(created_at: :DESC) }
  scope :sorted_deadline, -> { order(deadline: :DESC) }
end
