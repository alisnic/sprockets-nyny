require 'sprockets/nyny/version'
require 'sprockets/rails/helper'

module Sprockets
  module NYNY
    DEFAULT_PATHS = [
      'app/assets/javascripts',
      'app/assets/stylesheets',
      'app/assets/images'
    ]

    DEFAULT_URL = '/assets'

    def self.load_tasks!
      require 'sprockets/rails/task'
    end

    def assets
      scope_class.assets_environment
    end

    def serve_assets! options={}
      sprockets = Sprockets::Environment.new
      sprockets.logger = Logger.new(STDOUT)

      options.fetch(:paths, DEFAULT_PATHS).each do |path|
        sprockets.append_path(path)
      end
      sprockets = sprockets.index if ::NYNY.env.production?

      prefix = options.fetch(:url, DEFAULT_URL)
      scope_class.assets_environment  = sprockets
      scope_class.assets_prefix       = prefix
      builder.map (prefix) { run sprockets }
    end

    def self.registered app
      app.helpers ActionView::Helpers::AssetUrlHelper
      app.helpers ActionView::Helpers::AssetTagHelper
      app.helpers Sprockets::Rails::Helper
    end
  end
end