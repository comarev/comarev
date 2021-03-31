CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => ENV['ACCESS_KEY_ID'],
    :aws_secret_access_key => ENV['SECRET_ACCESS_KEY'],
    :region => ENV['REGION']
  }

  if Rails.env.development?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory = ENV['BUCKET']
  config.fog_public = false
end
