require "shrine"

require "./config/credentials"

# needed by `backgrounding` plugin
require "./jobs/promote_job"
require "./jobs/delete_job"

# Shrine.plugin :upload_endpoint
#
# Shrine.storages = {
#     cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
#     store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),       # permanent
# }

# Shrine.plugin :activerecord # or :activerecord
# Shrine.plugin :direct_upload, presign: true
# Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
# Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file


# Shrine.plugin :rack_file # for non-Rails apps
# use S3 for production and local file for other environments
if ENV["RACK_ENV"] == "production"
  require "shrine/storage/google_cloud_storage"

  # Shrine::Storage::GoogleCloudStorage.new(
  #     bucket: "store",
  #     default_acl: 'publicRead',
  #     object_options: {
  #         cache_control: 'public, max-age: 7200'
  #     },
  #     )

  # both `cache` and `store` storages are needed
  Shrine.storages = {
      cache: Shrine::Storage::GoogleCloudStorage.new(bucket: "cache-faculty-id-card"),
      store: Shrine::Storage::GoogleCloudStorage.new(bucket: "store-faculty-id-card"),
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

# delay promoting and deleting files to a background job (`backgrounding` plugin)
Shrine::Attacher.promote { |data| PromoteJob.perform_async(data) }
Shrine::Attacher.delete { |data| DeleteJob.perform_async(data) }