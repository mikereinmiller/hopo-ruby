module Hopo
  class Rater < API
    include Hopo::Utils::Calculator
    include Hopo::Utils::Sorter

    attr_accessor :line, :premium_mode, :sorter

    BASE_URL = 'https://integral.honestpolicy.com/api'
    API_VERSION = 1
    API_PATH = 'rates'

    def initialize(line, premium_mode='annually', sorter='premiums-asc')
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
      # TEMP Hack for v1 Until Integral API is cleaned Up (v2)
      if response['status']
        hash = { :errors => [response['message']] }

      elsif response['errors']
        hash = {:errors => [response['errors']]}

      else
        hash = {}
        rates = response['results']['rates']
        errors = response['results']['errors']
        risk = response['risk']

        calculated_rates = factor_rates(rates, premium_mode)
        sorted_rates = sort_rates(calculated_rates, sorter)

        hash.merge!( {:rates => sorted_rates} ) unless rates.blank?
        hash.merge!( {:errors => errors} ) unless errors.blank?
        hash.merge!( {:risk => risk} ) unless risk.blank?
      end

      hash
    end

  end
end
