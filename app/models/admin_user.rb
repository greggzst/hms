class AdminUser < ApplicationRecord
  devise :database_authenticatable,
         :rememberable,
         :validatable,
         :authentication_keys => [:username]

  def will_save_change_to_email?
    false
  end

  def email_required?
    false
  end
end
