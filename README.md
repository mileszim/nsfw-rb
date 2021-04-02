# nsfw-rb

WORK IN PROGRESS

Port of [nsfwjs](https://github.com/infinitered/nsfwjs) to ruby.

This RubyGem utilizes [nsfw_model](https://github.com/GantMan/nsfw_model) tensorlite converted to onnx format for loading in the runtime.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nsfw-rb'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install nsfw-rb

## Usage

```ruby
require "nsfw-rb"
```

```ruby
NSFW::Image.safe?("/path/to/nsfw.jpg")  #=> false
NSFW::Image.safe?("/path/to/normal.jpg") #=> true
```

```ruby
NSFW::Image.unsafe?("/path/to/nsfw.jpg")  #=> true
NSFW::Image.unsafe?("/path/to/normal.jpg") #=> false
```

```ruby
NSFW::Image.predictions("/path/to/image.jpg") # =>
# {
#  "porn"     => 0.020460745319724083, 
#  "sexy"     => 0.03264210745692253, 
#  "drawings" => 0.0227888785302639, 
#  "neutral"  => 0.9089052081108093, 
#  "hentai"   => 0.015203039161860943
# }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mileszim/nsfw-rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/mileszim/nsfw-rb/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Nsfw::Rb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mileszim/nsfw-rb/blob/master/CODE_OF_CONDUCT.md).
