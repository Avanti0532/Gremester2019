require "shrine"
require "shrine/storage/file_system"
class ImageUploader < Shrine
  plugin :determine_mime_type
  plugin :validation_helpers
  plugin :upload_endpoint
  plugin :pretty_location
  # plugin :store_dimensions
  # Attacher.validate do
  #   validate_mime_type_inclusion %w[image/jpeg image/png image/gif]
  #   validate_extension_inclusion %w[jpg jpeg png gif]
  #   validate_max_size  10*1024*1024 # 10MB
  #   validate_max_width  1000
  #   validate_max_height 1000
  # end
end