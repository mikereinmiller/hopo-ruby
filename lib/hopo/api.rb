module Hopo
  class API
    include Hopo::Connections::Request
    include Hopo::Connections::Response

    attr_reader :url, :path, :ssl, :default_params
    attr_accessor :uri, :http

    def initialize(url, path=nil, ssl=false)
      @default_params = {}
      @params = {}
      @url = url
      @path = path
      @ssl = ssl
      setup_connections
    end

    def params=(parameters)
      raise ArgumentError, 'parameters must be a hash {}' unless parameters.is_a?(Hash)
      @params = parameters
    end

    def params
      @params
    end

    def full_path
      "#{url}#{path}"
    end

    private

    def setup_connections
      @uri = URI.parse(full_path)
      @http = Net::HTTP.new(uri.host, uri.port)

      if @ssl
        @http.use_ssl = true
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      false
    end

    def perform_request(method, parameters, type)
      request = method.new( encode_params(parameters) )
      response = http.request(request)

      self.send("response_#{type}", response)
    end

    def encode_params(parameters)
      # uri.query = URI.encode_www_form( merge_parameters(parameters) )
      uri.query = merge_parameters(parameters).to_query
      uri.request_uri
    end

    def merge_parameters(parameters)
      raise ParameterError, 'parameters must be a hash {}' unless parameters.is_a?(Hash)
      hash_merge(self.default_params, self.params, parameters)
    end

    def hash_merge(*hashes)
      hashes.inject :merge
    end

  end
end
