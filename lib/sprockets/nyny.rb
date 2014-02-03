require 'sprockets/nyny/version'
require 'sprockets/rails/helper'

module Sprockets
  module NYNY
    def registered app
      app.helpers Sprockets::Rails::Helper
    end
  end
end