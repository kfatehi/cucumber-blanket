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

      def method_missing *args
        self.coverage_data.send(*args)
      end

      # Grab code coverage from the frontend
      # Currently this adds something like a few second or more to every scenario
      # The waits are lame but here's what it's trying to avoid
      #    unknown error: You must call blanket.setupCoverage() first.
      #       (Session info: chrome=31.0.1650.63)
      #       (Driver info: chromedriver=2.6.232908,platform=Mac OS X 10.9.1 x86_64) (Selenium::WebDriver::Error::UnknownError)
      def extract_from page, opts={setup_wait: 0.5, extract_wait: 0.5}
        @page = page
        sleep(opts[:setup_wait]) until coverage_is_setup?
        page.evaluate_script("blanket.onTestsDone();")
        sleep(opts[:extract_wait]) until data_ready?
        page_data = page.evaluate_script("window.CUCUMBER_BLANKET")
        @@coverage_data.accrue! page_data
        return page_data
      end

      def coverage_is_setup?
        @page.evaluate_script("window.CUCUMBER_BLANKET.is_setup")
      end

      def data_ready?
        @page.evaluate_script("window.CUCUMBER_BLANKET.done")
      end

      def percent
        total_lines = 0
        covered_lines = 0
        self.files.each do |filename, linedata|
          linedata.compact.each do |cov_stat|
            if cov_stat > 0
              covered_lines += 1
            end
            total_lines += 1
          end
        end
        if total_lines > 0
          return ((covered_lines.to_f / total_lines)*100).round(2)
        else
          return 0.0
        end
      end

      def write_html_report path
        File.open(path, 'w') do |file|
          file.write("Here's your HTML")
        end
      end
    end
  end
end
