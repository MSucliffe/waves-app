class User < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  def admin?
    false
  end

  def to_s
    name
  end
end
