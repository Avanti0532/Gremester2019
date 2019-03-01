class DocumentUploader < Shrine
  plugin :validation_helpers
  Attacher.validate do
    validate_max_size 5*1024*1024, message: "is too large (max is 5 MB)"
    validate_mime_type_inclusion %w[application/pdf]
  end
end