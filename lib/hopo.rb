#####################################################
#
# TODO:
# => RSpec Test
# => Better Documentation both GEM & API
# => Add Leads API, Vehicle API, Quality API
# => Clean Up Base Code
#
#####################################################


# Hopo Ruby libs
require 'net/http'
require 'uri'
require 'openssl'
require 'json'
require 'ostruct'

# Version
require "hopo/version"

# Extend Ruby Classes
require 'extend/object' unless defined?(::Rails)

# General
require 'hopo/errors'

# API Connections
require 'hopo/connections/request'
require 'hopo/connections/response'
require 'hopo/api'

# Rater - Auto, Home, Health, Life
require 'hopo/rater'
require 'hopo/rater/auto_rater'
require 'hopo/rater/home_rater'

# Base Hopo Module
module Hopo
  class << self
    attr_accessor :api_key

    def new_request(line)
      Rater.new(line)
    end

    def home_request
      HomeRater.new
    end

    def auto_request
      AutoRater.new
    end

  end
end

