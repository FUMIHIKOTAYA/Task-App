class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  enum status: {
    waiting: 0,
    working: 1,
    done: 2
  }

  scope :search_title, -> params { where(['title LIKE?', "%#{params[:title]}%"]) }
  scope :search_status, -> params { where(status: params[:status]) }
  scope :sorted, -> { order(created_at: :DESC) }
end
