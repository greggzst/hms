class Room < ApplicationRecord
  has_many :reservation_rooms
  has_many :reservations, through: :reservation_rooms

  has_many :photos

  validates :name, :capacity, :price, :room_amount, presence: true
  accepts_nested_attributes_for :photos, allow_destroy: true

  def primary_photo_url(version = nil)
    if primary = primary_photo
      "#{(version ? primary.image_url(version) : primary.image_url)}"
    else
      uploader = ImageUploader.new
      version ? uploader.send(version).url : uploader.url
    end
  end

  def primary_photo
    photos.where(is_primary: true).first
  end
end
