module Hopo
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Creates Hopo Initializer File"
      source_root File.expand_path('../templates', __FILE__)

      def copy_initializer
        template 'hopo_config.rb', 'config/initializers/hopo.rb'
      end

    end
  end
end
