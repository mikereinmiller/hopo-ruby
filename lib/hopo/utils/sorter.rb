module Hopo
  module Utils
    module Sorter

      def sort_rates(rates, mode)
        return if rates.blank?

        sort = mode.split('-')

        sorted_rates =
          if sort[1] == 'desc'
            Hash[rates.sort_by {|k, v| sort[0]=='companies' ? k : v }.reverse]
          else
            Hash[rates.sort_by {|k, v| sort[0]=='companies' ? k : v }]
          end
      end

    end
  end
end
