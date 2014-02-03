# Sprockets::NYNY

Provides integration for asset pipeline into New York, New York

## Installation

Add this line to your application's Gemfile:

    gem 'sprockets-nyny'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sprockets-nyny

## Usage

```ruby
require 'nyny'
require 'sprockets/nyny'

class App < NYNY::App
  register Sprockets::NYNY

  get '/' do
    #...
  end
end
```

After that, you can use `javascript_include_tag` and other assets pipeline
goodies in views, as you are used to in Rails.

## Configuring

You can configure the asset pipeline the same way you configure it in Rails:
```ruby
class App < NYNY::App
  register Sprockets::NYNY

  config.assets.debug = true
  ...

  #...
end
```
You can view the configuration defaults [here][defaults]

## Compiling for production
For that, you need a Rakefile:
```ruby
require 'sprockets/nyny'
require_relative 'server'

Sprockets::NYNY.load_tasks(App)

task :environment do
  App.new #=> needed for the the hooks to run, add your env logic below
end
```
(where server.rb is the file with the code of your app)

`rake assets:precompile` - will compile to the `public` path

## Contributing

1. Fork it ( http://github.com/<my-github-username>/sprockets-nyny/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[defaults]: https://github.com/alisnic/sprockets-nyny/blob/master/lib/sprockets/nyny/builder.rb#L6