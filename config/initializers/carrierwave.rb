CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                         # required
  config.fog_credentials = {
    provider:              'AWS',                         # required
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],      # required
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # required
    region:                'ap-northeast-1',              # optional, defaults to 'us-east-1'
    #host:                  's3.example.com',             # optional, defaults to nil
    #endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
  }

  case Rails.env
    when 'production'
        config.fog_directory  = ENV['BUCKET_NAME'] # required
        config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/infra-test-app-production'
    when 'development'
        config.fog_directory  = ENV['BUCKET_NAME']
        config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/infra-test-app-development'
  end

  config.fog_public     = false                           # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
end
