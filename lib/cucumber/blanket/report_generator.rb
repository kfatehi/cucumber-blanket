require 'haml'
module Cucumber
  module Blanket
    class ReportGenerator
      TEMPLATE_DIR = File.join(File.dirname(__FILE__), '../../../templates')
      
      def initialize(mode, coverage_data)
        case mode
        when :html
          template = File.join(TEMPLATE_DIR, 'html_report.html.haml')
          @engine = Haml::Engine.new(File.read(template))
        else
          raise "Unsupported report #{mode}"
        end
        @data = coverage_data
      end

      def render
        @engine.render(self)
      end
    end
  end
end
