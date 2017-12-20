class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :reservations

  attr_reader :do_not_login
  attr_reader :accept_terms

  validates :firstname, :lastname, :valid_document_number, presence: true, if: ->(user) { user.has_account }
  validates_acceptance_of :accept_terms

  def do_not_login= value
    @do_not_login = value.to_i == 1
  end

  def accept_terms= value
    @accept_terms = value.to_i == 1
  end

  protected
    def password_required?
      return false if !has_account || do_not_login
      super
    end
end
