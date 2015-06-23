class User < ActiveRecord::Base
  has_secure_password
  validates :full_name, presence: true

  validates :email, presence: true, uniqueness: true,
            format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}

  enum role: %w(default, admin)

  has_many :orders

end
