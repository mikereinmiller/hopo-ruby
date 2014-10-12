module Hopo
  class Rater < API
    include Hopo::Utils::Calculator
    include Hopo::Utils::Sorter

    attr_accessor :line, :premium_mode, :sorter

    # BASE_URL = 'https://integral.dev/api'
    BASE_URL = 'https://integral.honestpolicy.com/api'
    API_VERSION = 2
    API_PATH = 'rates'

    def initialize(line, premium_mode='annually', sorter='premium-asc')
      unless Hopo.api_key
        raise AuthenticationError, 'No API key provided.  Set your API key using "Hopo.api_key = <API-KEY>".'
      end

      super(BASE_URL, "/v#{API_VERSION}/#{API_PATH}", true)

      @premium_mode = premium_mode
      @sorter = sorter

      @default_params = {
        :key => Hopo.api_key,
        :line => line
      }

    end

    private

    def response_json(response)
      format_response( JSON.parse(response.body) )
    end

    def format_response(response)
      # Calculate and Sort Rates if available.
      unless response['status']['type'] == 'error'
        rates = response['data']

        calculated_rates = factor_rates(rates, premium_mode)
        sorted_rates = sort_rates(calculated_rates, sorter)

        response['data'] = sorted_rates
      end

      response
    end

  end
end
