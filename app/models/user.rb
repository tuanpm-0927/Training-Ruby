class User < ApplicationRecord
    before_save { email.downcase! }
    validates :name, presence: true, length: { maximum: Settings.validates.users.name_maximum }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: Settings.validates.users.email_maximum },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: Settings.validates.users.password_minium }
end
