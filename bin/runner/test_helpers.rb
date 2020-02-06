require "pry"

module PiperRunnerHelpers
  module TestHelpers
    NAMED_SPEC_FILE         = "named_service_spec.rb".freeze
    NAMED_TEST_FILE         = "named_service_test.rb".freeze

    def build_spec_files
      require("rspec/core")
      say("RSpec detected", :green)
      template "templates/#{NAMED_SPEC_FILE}", "spec/services/#{service_filename}_spec.rb"
      true
    rescue LoadError
      nil
    end

    def build_test_files
      require("minitest")
      say("Minitest detected", :green)
      template "templates/#{NAMED_TEST_FILE}", "test/services/#{service_filename}_test.rb"
      true
    rescue LoadError
      nil
    end
  end
end
