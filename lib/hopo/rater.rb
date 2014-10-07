module Hopo
  class Rater < API
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

      else
        hash = {}
        rates = response['results']['rates']
        errors = response['results']['errors']
        risk = response['risk']

        hash.merge!( {:rates => factor_premiums(rates) } ) unless rates.blank?
        hash.merge!( {:errors => errors} ) unless errors.blank?
        hash.merge!( {:risk => risk} ) unless risk.blank?

      end

      hash
    end

    def factor_premiums(rates)
      premiums = {:monthly => 12, :triannually => 3, :quarterly => 4, :biannually => 2, :annually => 1}
      divisor = premiums[premium_mode.to_sym] || 1

      rates.each do |k, v|
        rates[k] = v / divisor
      end

      sort_rates(rates) unless sorter.blank?
    end

    def sort_rates(rates)
      sort = sorter.split('-')

      sorted_rates =
        if sort[1] == 'desc'
          Hash[rates.sort_by {|k, v| sort[0]=='companies' ? k : v }.reverse]
        else
          Hash[rates.sort_by {|k, v| sort[0]=='companies' ? k : v }]
        end
    end

  end
end
