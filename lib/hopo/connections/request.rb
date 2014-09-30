module Hopo
  module Connections
    module Request
      module ClassMethods
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      # Perform a GET request to a path
      def get(parameters={}, type='json')
        perform_request Net::HTTP::Get, parameters, type
      end

      # Perform a POST request to a path
      def post(parameters={}, type='json')
        perform_request Net::HTTP::Post, parameters, type
      end

      # Perform a PATCH request to a path
      def patch(parameters={}, type='json')
        perform_request Net::HTTP::Patch, parameters, type
      end

      # Perform a PUT request to a path
      def put(parameters={}, type='json')
        perform_request Net::HTTP::Put, parameters, type
      end

      # Perform a DELETE request to a path
      def delete(parameters={}, type='json')
        perform_request Net::HTTP::Delete, parameters, type
      end

    end
  end
end
