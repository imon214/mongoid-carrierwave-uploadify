# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # -- RMagick and MiniMagick requires ImageMagick
  # -- ImageScience requires Freeimage
  # Include RMagick or ImageScience support
  #     include CarrierWave::RMagick
  #     include CarrierWave::ImageScience
  include CarrierWave::MiniMagick

  # -- These options set in config/initializers/carrierwave.rb
  # Choose what kind of storage to use for this uploader
  #     storage :file
  #     storage :s3

  # Override the directory where uploaded files will be stored
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded
  #     def default_url
  #       "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  #     end

  # Process files as they are uploaded.
  #     process :scale => [200, 300]
  #
  #     def scale(width, height)
  #       # do something
  #     end

  process :resize_to_limit => [640, 640]

  # Create different versions of your uploaded files
  #     version :thumb do
  #       process :scale => [50, 50]
  #     end

  version :thumb do
    process :resize_to_limit => [160, 160]
  end

  # Add a white list of extensions which are allowed to be uploaded,
  # for images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files
  #     def filename
  #       "something.jpg" if original_filename
  #     end
end
