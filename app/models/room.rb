class Room < ApplicationRecord
  has_many :reservation_rooms
  has_many :reservations, through: :reservation_rooms

  has_many :photos

  validates :name, :capacity, :price, :room_amount, presence: true
  accepts_nested_attributes_for :photos,
            allow_destroy: true, reject_if: ->(photo) { photo['image'].blank? }

  def primary_photo
    photos.where(is_primary: true).first
  end
end
