module Hopo
  class HomeRater < Rater

    def initialize(premium_mode='annually', sorter='premiums-asc', version=1, path='rates')
      super('home', premium_mode, sorter, version, path)
    end

    def required_fields?
      {
        zip: 'Five diging Zip Code for location',
        cov_a: 'The Coverage Amount for the Home - Minimum 10000',
        year_built: 'Year Home was built - 1800 to 2014',
        construction_type: 'Material used for Home - [Frame, Masonry, Adobe, Log]'
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
