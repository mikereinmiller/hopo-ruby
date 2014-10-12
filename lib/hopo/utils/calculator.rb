module Hopo
  module Utils
    module Calculator

      def factor_rates(rates, mode)
        return if rates.blank?

        premiums = {:monthly => 12, :triannually => 3, :quarterly => 4, :biannually => 2, :annually => 1}
        divisor = premiums[mode.to_sym] || 1

        rates.each {|rate| rate['premium'] /= divisor unless rate['premium'].blank? }

        rates
      end

    end
  end
end
