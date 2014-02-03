#!ruby -I ../lib -I lib
require 'nyny'
require 'haml'
require 'coffee_script'
require 'sprockets/nyny'

class App < NYNY::App
  register Sprockets::NYNY

  enable_sprockets :url => '/assets', :paths => [
    'vendor/javascripts',
    'app/assets/javascripts',
    'app/assets/stylesheets',
    'app/assets/images'
  ]

  get '/' do
    render 'app/views/index.haml'
  end
end

App.run!
