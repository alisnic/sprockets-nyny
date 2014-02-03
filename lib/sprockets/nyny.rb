require 'sprockets/nyny/version'
require 'sprockets/nyny/builder'

module Sprockets
  module NYNY
    def self.load_tasks app
      require 'sprockets/rails/task'
      Sprockets::Rails::Task.new(app)
    end

    alias_method :run!, :original_run
    def run! port=9292
      before_run_hooks.each do |hook|
        hook.call(self)
      end
      original_run(port)
    end

    def before_run &block
      before_run_hooks << Proc.new(&block)
    end

    def self.registered app
      app.send :include, ActiveSupport::Configurable
      app.inheritable :before_run_hooks,  []
      app.inheritable :assets,            Sprockets::Environment.new

      app.helpers ActionView::Helpers::AssetUrlHelper
      app.helpers ActionView::Helpers::AssetTagHelper
      app.helpers Sprockets::Rails::Helper

      Builder.build_config(app.config)
      Builder.add_hooks(app)
    end
  end
end