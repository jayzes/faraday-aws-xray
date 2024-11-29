# Faraday AWS X-Ray Middleware

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/jayzes/faraday-aws-xray/ci)](https://github.com/jayzes/faraday-aws-xray/actions?query=branch%3Amain)
[![Gem](https://img.shields.io/gem/v/faraday-aws-xray.svg?style=flat-square)](https://rubygems.org/gems/faraday-aws-xray)
[![License](https://img.shields.io/github/license/jayzes/faraday-aws-xray.svg?style=flat-square)](LICENSE.md)

Faraday 2+ middleware to instrument spans for [AWS X-Ray](https://aws.amazon.com/xray/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faraday-aws-xray'
```

And then execute:

```shell
bundle install
```

Or install it yourself as:

```shell
gem install faraday-aws-xray
```

## Usage

```ruby
require 'faraday/aws/xray'
```

Then wherever you configure your Faraday connection, add the middleware:

```ruby
Faraday.new(...) do |conn|
  conn.use Faraday::Aws::XRay::Middleware
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

Then, run `bin/test` to run the tests.

To install this gem onto your local machine, run `rake build`.

To release a new version, make a commit with a message such as "Bumped to 0.0.2" and then run `rake release`.
See how it works [here](https://bundler.io/guides/creating_gem.html#releasing-the-gem).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/ajayzes/faraday-aws-xray/faraday-aws-xray).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
