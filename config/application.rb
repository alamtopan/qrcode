require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Absensi
  class Application < Rails::Application
    config.time_zone = 'Jakarta'
    config.active_record.raise_in_transactional_callbacks = true
    config.assets.enabled = true
    config.assets.paths << Rails.root.join("app", "assets", "fonts", "yml")
    config.autoload_paths += %W(#{config.root}/lib)
    config.assets.paths << Rails.root.join("vendor", "assets", "fonts")
    config.assets.paths << Rails.root.join("vendor", "assets", "images")
    config.assets.paths << Rails.root.join("vendor", "assets", "stylesheets")
    config.assets.paths << Rails.root.join("vendor", "assets", "javascripts")
    config.exceptions_app = self.routes
    config.assets.initialize_on_precompile = true
    config.action_dispatch.ignore_accept_header = true
    config.assets.precompile += %w(.svg .eot .woff .ttf)  
    config.quiet_assets = true
    config.action_dispatch.default_headers = {
        'X-Frame-Options' => 'ALLOWALL',
        'Vary' => 'Accept-Encoding'
    }
    config.middleware.use HtmlCompressor::Rack, {preserve_line_breaks: false,javascript_compressor: :ugglifier, css_compressor: :sass, remove_intertag_spaces: true, remove_quotes: false}
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w( ckeditor/* )
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
  end
end
