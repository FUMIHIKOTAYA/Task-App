class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  before_update :prevent_admin_zero
  before_destroy :prevent_admin_disappear

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: true
  before_validation { email.downcase! }

  private

  def prevent_admin_zero
    if User.where(admin: true).count == 1 && self.admin == false
      throw(:abort)
    end
  end

  def prevent_admin_disappear
    if User.where(admin: true).count <= 1 && self.admin == true
      throw(:abort)
    end
  end
end
