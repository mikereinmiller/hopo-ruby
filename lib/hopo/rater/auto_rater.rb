module Hopo
  class AutoRater < Rater

    def initialize(premium_mode='annually', sorter='premiums-asc', version=1, path='rates')
      super('auto', premium_mode, sorter, version, path)
    end

    def required_fields?
      {
        zip: 'Five diging Zip Code for location'
      }
    end

    def optional_fields?
      {
        test1: 'test 1',
        test2: 'test 2',
        test3: 'test 3'
      }
    end

  end
end
