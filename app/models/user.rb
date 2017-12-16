class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :reservations
  validates :firstname, :lastname, :valid_document_number, presence: true, if: ->(user) { user.has_account }

  protected
    def password_required?
      return false unless has_account
      super
    end
end
