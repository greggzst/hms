class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable,
         :validatable,
         :authentication_keys => [:username]

  def will_save_change_to_email?
    false
  end
end
