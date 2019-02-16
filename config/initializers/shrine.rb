require "shrine"
if ENV["RACK_ENV"] == "production"
  require "shrine/storage/google_cloud_storage"

  Google::Cloud::Storage.configure do |config|
    config.project_id  = ENV["GOOGLE_CLOUD_PROJECT"]
    config.credentials = JSON.parse(ENV['GOOGLE_CLOUD_CREDENTIALS'])
  end
  Shrine.storages = {
      cache: Shrine::Storage::GoogleCloudStorage.new(
          bucket: 'cache-faculty-id-card'),
      store: Shrine::Storage::GoogleCloudStorage.new(
          bucket: 'store-faculty-id-card')

  }
else
  require "shrine/storage/file_system"

  # both `cache` and `store` storages are needed
  Shrine.storages = {
      cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
      store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),
  }
end

Shrine.plugin :activerecord
Shrine.plugin :backgrounding
Shrine.plugin :logging
Shrine.plugin :determine_mime_type
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data

if ENV["RACK_ENV"] == "production"
  Shrine.plugin :presign_endpoint, presign_options: -> (request) {
    # Uppy will send the "filename" and "type" query parameters
    filename = request.params["filename"]
    type     = request.params["type"]

    {
        content_disposition:    ContentDisposition.inline(filename), # set download filename
        content_type:           type,                                # set content type (defaults to "application/octet-stream")
        content_length_range:   0..(10*1024*1024),                   # limit upload size to 10 MB
    }
  }
else
  Shrine.plugin :upload_endpoint
end