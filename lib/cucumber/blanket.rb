require "cucumber/blanket/version"
require "cucumber/blanket/coverage_data"

module Cucumber
  module Blanket
    class << self
      @@coverage_data = CoverageData.new

      def coverage_data
        @@coverage_data
      end

      def reset!
        @@coverage_data = CoverageData.new
      end

      def files
        self.coverage_data.files
      end

      # Grab code coverage from the frontend
      # Currently this adds >1 second to every scenario, but it's worth it
      def extract_from page
        sleep 0.5 # Give blanketJS time to setupCoverage() before we go to stop it
        page.evaluate_script("blanket.onTestDone();")
        page.evaluate_script("blanket.onTestsDone();")
        sleep 0.5 # Allow time for blanketJS and the adapter to prepare the report
        page_data = page.evaluate_script("window.COVERAGE_RESULTS")
        @@coverage_data.accrue! page_data
        return page_data
      end
    end
  end
end
