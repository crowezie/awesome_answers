class User < ActiveRecord::Base
  has_secure_password

  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify

  validates :email, presence: true, uniqueness: true,
  format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def full_name
    "#{first_name} #{last_name}".strip
  end


end
