class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :delete_all
  has_one :avatar, as: :imageable, dependent: :destroy, inverse_of: :imageable
  has_one :cover, as: :imageable, dependent: :destroy, inverse_of: :imageable
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }
end
