require 'active_support/configurable'

# taken from https://github.com/amatsuda/kaminari/blob/master/lib/kaminari/config.rb
module Westfield
  class Paginator
    # Configures global settings for pagination
    #   Westfield::Paginator.configure do |config|
    #     config.default_per_page = 10
    #   end
    def self.configure(&block)
      yield @config ||= Westfield::Paginator::Configuration.new
    end

    # Global settings for Westfield::Paginator
    def self.config
      @config
    end

    # need a Class for 3.0
    class Configuration
      include ActiveSupport::Configurable
      config_accessor :default_per_page
      config_accessor :max_per_page

      def param_name
        config.param_name.respond_to?(:call) ? config.param_name.call : config.param_name
      end

      # define param_name writer (copied from AS::Configurable)
      writer, line = 'def param_name=(value); config.param_name = value; end', __LINE__
      singleton_class.class_eval writer, __FILE__, line
      class_eval writer, __FILE__, line
    end

    configure do |config|
      config.default_per_page = 10
      config.max_per_page = 100
    end
  end
end
