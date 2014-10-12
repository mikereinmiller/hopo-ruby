module Hopo
  class AutoRater < Rater

    def initialize(premium_mode='annually', sorter='premium-asc')
      super('auto', premium_mode, sorter)
    end

    def required_fields?
      {
        :zip => 'Five diging Zip Code for location',
        :model_year => 'Not Required - defaults to 2012',
        :make => 'Not Required - defaults to Toyota',
        :model => 'Not Required - defaults to Camry'
      }
    end

    def optional_fields?
      {
        :num_vehicles => 'Number representing the total count of vehicles',
        :num_drivers => 'Number representing the total number of drivers'
      }
    end

  end
end
