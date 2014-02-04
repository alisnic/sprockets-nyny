require 'sprockets/nyny/version'
require 'sprockets/nyny/builder'

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
      app.helpers ActionView::Helpers::AssetUrlHelper
      app.helpers ActionView::Helpers::AssetTagHelper
      app.helpers Sprockets::Rails::Helper

      Builder.build_environment(app)
      Builder.build_config(app.config)
      Builder.add_hooks(app)
    end
  end
end
