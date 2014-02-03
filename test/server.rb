#!ruby -I ../lib -I lib
require 'nyny'
require 'haml'
require 'coffee_script'
require 'sprockets/nyny'

class App < NYNY::App
  register Sprockets::NYNY
  config.assets.precompile << 'app/assets/javascripts/application.js'

  get '/' do
    render 'app/views/index.haml'
  end
end

App.run! if __FILE__ == $0
