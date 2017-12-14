class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :reservations

  protected
    def password_required?
      return false unless has_account
      super
    end
end
