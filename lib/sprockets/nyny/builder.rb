require 'sprockets/rails/helper'

module Sprockets
  module NYNY
    class Builder
      def self.build_config config
        config.assets            = ActiveSupport::OrderedOptions.new
        config.assets._blocks    = []
        config.assets.paths      = ['app/assets/javascripts',
          'app/assets/stylesheets', 'app/assets/images']
        config.assets.prefix     = "/assets"
        config.assets.precompile = [/(?:\/|\\|\A)application\.(css|js)$/]
        config.assets.version    = ""
        config.assets.debug      = false
        config.assets.compile    = true
        config.assets.digest     = false
      end

      def self.build_environment app
        sprockets = Sprockets::Environment.new do |env|
          env.version = ::NYNY.env
          path        = ::NYNY.root.join "/tmp/cache/assets/#{::NYNY.env}"
          env.cache   = Sprockets::Cache::FileStore.new(path)
          env.logger  = Logger.new(STDOUT)
        end

        app.inheritable :assets, sprockets
      end

      def self.configure_scope config, app
        config.assets.paths.each do |path|
          app.assets.append_path path
        end

        app.scope_class.debug_assets  = config.assets.debug
        app.scope_class.digest_assets = config.assets.digest
        app.scope_class.assets_prefix = config.assets.prefix

        manifest_path = "#{::NYNY.root}/public#{config.assets.prefix}"

        if config.assets.compile
          app.scope_class.assets_environment = app.assets
          app.scope_class.assets_manifest = Sprockets::Manifest.new(app.assets, manifest_path)
        else
          app.scope_class.assets_manifest = Sprockets::Manifest.new(manifest_path)
        end
      end

      def self.add_hooks app
        app.before_run do |app|
          config = app.config

          unless config.assets.version.blank?
            app.assets.version += "-#{config.assets.version}"
          end

          configure_scope(config, app)
          app.assets.js_compressor  = config.assets.js_compressor
          app.assets.css_compressor = config.assets.css_compressor
          app.assets = app.assets.index if ::NYNY.env.production?

          if config.assets.compile
            p config.assets.prefix, app.assets
            app.builder.map (config.assets.prefix) { run app.assets }
          end
        end
      end
    end
  end
end