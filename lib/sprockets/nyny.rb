require 'sprockets/nyny/version'
require 'sprockets/rails/helper'

module Sprockets
  module NYNY
    def self.load_tasks!
      #TODO: implement
    end

    def enable_sprockets options
      sprockets = Sprockets::Environment.new
      options.fetch(:paths, []).each {|path| sprockets.append_path(path)}
      sprockets = sprockets.index if ::NYNY.env.production?

      prefix = options.fetch(:url, '/assets')
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