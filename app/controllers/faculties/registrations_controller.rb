require 'config/initializers/shrine'
class RegistrationsController < Devise::RegistrationsController
  def create
    super do
      bucket = $storages(:store)
      file_url = params["id_card"].tempfile.path
      bucket.create_file file_url
      @faculty.id_card_data = file_url
      @faculty.save!
    end
  end
end