require 'spec_helper'

describe Cucumber::Blanket do

  describe "#files" do
    it "is a shortcut for coverage_data#files" do
      subject.files.should eq subject.coverage_data.files
    end
  end

  describe "#sources" do
    it "is a shortcut for coverage_data#sources" do
      subject.sources.should eq subject.coverage_data.sources
    end
  end

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

  describe "#percent" do
    before(:each) { subject.reset! }
    it "returns total percent coverage of known lines of code as float" do
      subject.extract_from(FakePage.new)
      subject.percent.should eq 75.0
    end
    context "no data harvested yet" do
      it "returns zero" do
        subject.percent.should eq 0.0
      end
    end
  end
end
