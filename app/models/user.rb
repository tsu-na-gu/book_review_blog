class User < ApplicationRecord
  attr_accessor :password, :password_confirmation

  before_save :downcase_email
  validates :name, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]*\.?[a-z\d\-]+\.{1}[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  def password=(password)
    @password = password
    self.password_salt = User.generate_salt
    self.password_hash = User.hash_password(password, password_salt)
  end

  def self.authenticate(email, password)
    return nil if email.blank?

    user = User.find_by(email: email.downcase)
    return nil if user.nil?

    password_hash = hash_password(password, user.password_salt)

    return user if password_hash == user.password_hash
  end

  def self.hash_password(password, salt)
    BCrypt::Engine.hash_secret(password, salt)
  end

  def self.generate_salt
    BCrypt::Engine.generate_salt
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def password_required?
    !persisted? || password.present?
  end
end
