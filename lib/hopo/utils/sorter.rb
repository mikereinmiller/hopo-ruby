module Hopo
  module Utils
    module Sorter

      def sort_rates(rates, mode)
        return if rates.blank?

        sort_value = mode.split('-')[0]
        sort_direction = mode.split('-')[1]

        # Simple hack for sorting nil values last.
        if sort_direction == 'desc'
          puts '**************************'
          rates.sort_by! { |rate| rate[sort_value] || 0 }.reverse!
        else
          puts '--------------------------'
          rates.sort_by! { |rate| rate[sort_value] || 9999999 }
        end
      end

    end
  end
end
