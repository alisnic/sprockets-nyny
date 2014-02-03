#!ruby -I ../lib -I lib
require 'nyny'
require 'haml'
require 'coffee_script'
require 'sprockets/nyny'

class App < NYNY::App
  register Sprockets::NYNY
  serve_assets!

  get '/' do
    render 'app/views/index.haml'
  end
end

App.run!
