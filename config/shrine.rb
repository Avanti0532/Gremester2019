require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),       # permanent
}
Shrine.plugin :upload_endpoint
Shrine.plugin :activerecord # or :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file

mount Shrine.upload_endpoint(:cache) => "/upload"
# Shrine.plugin :rack_file # for non-Rails apps
z