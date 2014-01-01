require 'spec_helper'

describe Cucumber::Blanket do
  describe "#extract_from" do
    let(:page) { FakePage.new }
    context "Selenium-returned blanket.js coverage data structure characteristics" do
      let(:cov) do
        subject.extract_from(page)
        subject.coverage_data
      end
      specify { cov.should have_key 'files' }
      it "shows lines of coverage for each javascript file" do
        cov['files'].each do |filename,linedata|
          filename.should match(/.js$/)
          linedata.each_with_index do |cov_stats,line_number|
            line_number.should be_a Integer
            (cov_stats || 0).should be_a Integer # can be nil
          end
        end
      end
    end
  end
end
