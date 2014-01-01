require 'pry'
require 'json'
require 'cucumber/blanket'

class FakePage
  attr_reader :coverage_data

  def initialize
    @coverage_data = parse_fixture_json
  end

  def parse_fixture_json
    json = File.read(File.join(File.dirname(__FILE__),'fixtures','simple.json'))
    return JSON.parse(json)[0] # How it looks when we get it from Selenium
  end

  def evaluate_script script
    if script == "window.COVERAGE_RESULTS"
      self.coverage_data
    end
  end

  ##
  # Helper to change the lines of coverage for testing flattening
  # of two sets of coverage data
  def cov_lines
    
  end
end

