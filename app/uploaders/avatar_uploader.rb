class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process resize_to_limit: [500, nil]

  def store_dir
    'uploads/'
  end
end
