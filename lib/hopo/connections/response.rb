module Hopo
  module Connections
    module Response
      module ClassMethods
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      private

      # RAW response
      def response_raw(response)
        response.body
      end

      # Formatted JSON response
      def response_json(response)
        JSON.parse(response.body)
      end

      # Formatted OpenStruct response
      def response_struct(response)
        OpenStruct.new( request_json(response) )
      end

    end
  end
end
