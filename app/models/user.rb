class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  validates :full_name, presence: true
  validates_length_of :display_name,
                     minimum: 2, maximum: 32, allow_blank: true

  validates :email, presence: true, uniqueness: true,
            format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}

  enum role: %w(default, admin)


end
