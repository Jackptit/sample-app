class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  before_save :downcase_email
  has_secure_password
  def downcase_email
    self.email.downcase!
  end
  def User.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end
end
