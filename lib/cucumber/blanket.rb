require "cucumber/blanket/version"

module Cucumber
  module Blanket
    class << self
      @@coverage_data = []

      # Grab code coverage from the frontend
      # Currently this adds >1 second to every scenario, but it's worth it
      def extract_from page
        sleep 0.5 # Give blanketJS time to setupCoverage() before we go to stop it
        page.evaluate_script("blanket.onTestDone();")
        page.evaluate_script("blanket.onTestsDone();")
        sleep 0.5 # Allow time for blanketJS and the adapter to prepare the report
        @@coverage_data << page.evaluate_script("window.COVERAGE_RESULTS")
        flatten!
      end

      def flatten!
        # go through every line of every file and OR it all together
        # e.g. line 1 is 1 and 0, so it is 1
        # @@coverage_data should never exceed length 2
      end

      def generate_report
        # but for now, so you know it's there...
        puts "coverage data length: #{@@coverage_data.length}"
      end
    end
  end
end
