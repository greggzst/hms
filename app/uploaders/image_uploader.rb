class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path('fallback/picture.svg')
  end

  process resize_to_fit: [1024, 1024]

  version :preview do
    process resize_to_fill: [380, 300]
  end

  version :thumb do
    process resize_to_fill: [64, 64]
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

end
