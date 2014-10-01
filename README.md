
# hopo-ruby

A library for using the Honest Policy API, currently supports Auto and Home Raters.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hopo-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hopo-ruby


## Setup

You need to set the **api_key** given by honestpolicy before you can use the raters.  This can be set as simply as:

```ruby
Hopo.api_key = 'your-unique-api-key'
```

If you are using rails, you can run the generator to setup a config/initializer file for you.  This file will require the hopo library and add a line to set your api_key.  Make sure you do not commit your actual key to your repository.

    $ rails g hopo:install


## Usage

    coming soon
