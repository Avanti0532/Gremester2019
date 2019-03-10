# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( yeti.css )
Rails.application.config.assets.precompile += %w( banner.css )
Rails.application.config.assets.precompile += %w( yeti.js )
Rails.application.config.assets.precompile += %w( sInterestedSchools.js )
Rails.application.config.assets.precompile += %w( file_upload.js )
Rails.application.config.assets.precompile += %w( university.css )
Rails.application.config.assets.precompile += %w( sProfileNav.css )
Rails.application.config.assets.precompile += %w( jasmine-jquery.js)
Rails.application.config.assets.precompile += %w( sInterestedSchools.css)
Rails.application.config.assets.precompile += %w( edit_profile.js)


# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
