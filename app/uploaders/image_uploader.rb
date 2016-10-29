# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  def default_url(*args)
    "/assets/default.png"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :banner_large do
    process :resize_to_fit => [1200, 1200]
  end

  version :large do
    process :resize_to_fit => [500, 500]
  end

  version :normal do
    process :resize_to_fit => [300, 300]
  end

  version :small do
    process :resize_to_fit => [170, 170]
  end

  version :thumb do
    process :resize_to_fit => [60, 60]
  end

  def extension_white_list
    %w(jpg jpeg png gif)
  end

end
