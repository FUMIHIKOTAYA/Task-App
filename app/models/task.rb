class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  enum status: {
    waiting: 0,
    working: 1,
    done: 2
  }
end
