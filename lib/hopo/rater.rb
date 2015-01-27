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
      _res = begin
        JSON.parse(response.body)
      rescue
        mock_response(response.code)
      end

      format_response(_res)
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

    # mocks the type of response we get from our integral server
    def mock_response(code)
      {
        'status' => {
          'type' => 'error',
          'code' => code,
          'message' => 'An Error occured parsing the response',
          'warnings' => '',
          'timestamp' => DateTime.now.iso8601
        },
        'risk' => {},
        'response' => {},
        'data' => []
      }
    end

  end
end
