require 'rack'
require 'sprockets/nyny/version'
require 'sprockets/nyny/builder'

module Rack
  class Builder
    #1.6 backport
    def warmup(prc=nil, &block)
      @warmup = prc || block
    end

    alias_method :build_app, :to_app
    def to_app
      @warmup.call if @warmup
      build_app
    end
  end
end

module Sprockets
  module NYNY
    def self.load_tasks app
      require 'sprockets/rails/task'
      Sprockets::Rails::Task.new(app)
    end

    def root
      ::NYNY.root
    end

    def before_run &block
      before_run_hooks << Proc.new(&block)
    end

    def self.registered app
      app.inheritable :config, OpenStruct.new
      app.inheritable :before_run_hooks, []

      app.helpers ActionView::Helpers::AssetUrlHelper
      app.helpers ActionView::Helpers::AssetTagHelper
      app.helpers Sprockets::Rails::Helper

      Builder.build_environment(app)
      Builder.build_config(app.config)
      Builder.add_hooks(app)

      app.builder.warmup do
        app.before_run_hooks.each {|h| h.call(app)}
      end
    end
  end
end