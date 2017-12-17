class Photo < ApplicationRecord
  belongs_to :room
  mount_uploader :image, ImageUploader
  before_destroy :set_new_primary

  validates :image, presence: true

  def set_primary
    self.is_primary = true
    self.save
  end

  def unset_primary
    self.is_primary = false
    self.save
  end

  private
    def set_new_primary
      secondary_owner_photos = self.owner.photos.where(is_primary: false)
      if self.is_primary && secondary_owner_photos.any?
        new_primary = secondary_owner_photos.first
        new_primary.set_primary
      end
    end
end
