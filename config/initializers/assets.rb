# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
 Rails.application.config.assets.precompile += %w( lightgreen.js )
 Rails.application.config.assets.precompile += %w( bootstrap.js )
 Rails.application.config.assets.precompile += %w( lightgreen.css )
 Rails.application.config.assets.precompile += %w( bootstrap_and_overrides.css )
 Rails.application.config.assets.precompile += %w( personal.css )
 Rails.application.config.assets.precompile += %w( purestyle.scss )
 Rails.application.config.assets.precompile += %w( purestyle.css )
 Rails.application.config.assets.precompile += %w( jquery.md5.js )
 Rails.application.config.assets.precompile += %w( zepto.min.js )
 Rails.application.config.assets.precompile += %w( md5.js )
 