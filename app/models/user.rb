class User < ApplicationRecord
  # -> relationship
  has_many :posts

  # -> security
  has_secure_password

  # -> misc
  before_save { self.email = email.downcase } ## -> hash password

  # -> validates
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true, confirmation: true

  alias_attribute :password, :password_digest
end
