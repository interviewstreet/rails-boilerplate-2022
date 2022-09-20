class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :blog
  
  enum role: {
    user: 0,
    admin: 1
  }

  def details
    return {
      id: id,
      name: name,
      email: email,
      role: role,
    }
  end
end
