# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( yeti.css )
Rails.application.config.assets.precompile += %w( banner.css )
Rails.application.config.assets.precompile += %w( yeti.js )
Rails.application.config.assets.precompile += %w( fstudentList.js )
Rails.application.config.assets.precompile += %w( fstudentList.css )
Rails.application.config.assets.precompile += %w( sInterestedSchools.js )
Rails.application.config.assets.precompile += %w( file_upload.js )
Rails.application.config.assets.precompile += %w( university.css )
Rails.application.config.assets.precompile += %w( editProfile.css )
Rails.application.config.assets.precompile += %w( sProfileNav.css )
Rails.application.config.assets.precompile += %w( jasmine-jquery.js)
Rails.application.config.assets.precompile += %w( sInterestedSchools.css)
Rails.application.config.assets.precompile += %w( edit_profile.js)
Rails.application.config.assets.precompile += %w( undergrad_universities.css )
Rails.application.config.assets.precompile += %w( undergrad_universities.js )
Rails.application.config.assets.precompile += %w( yeti/research_interests.js )
Rails.application.config.assets.precompile += %w( research_interests.css )


# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
