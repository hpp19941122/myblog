RailsKindeditor.setup do |config|
  config.upload_dir = 'uploads/kindeditor'

  # Allowed file types for upload.
  config.upload_image_ext = %w[gif jpg jpeg png bmp]
  config.upload_flash_ext = %w[swf flv]
  config.upload_media_ext = %w[swf flv mp3 wav wma wmv mid avi mpg asf rm rmvb]
  config.upload_file_ext = %w[doc docx xls xlsx ppt htm html txt zip rar gz bz2]
  config.image_resize_to_limit = [1200, 1200]
  
  # if you have config in your rails application like this:
  # /config/enviroments/production.rb
  #   # config.action_controller.asset_host = "http://asset.example.com"
  #   # config.assets.prefix = "assets_prefx"
  # then you should:
  #
  # config.asset_url_prefix = "http://asset.example.com/assets_prefx/" if Rails.env.production?

end
