require 'spec_helper'

describe Cucumber::Blanket::CoverageData do
  let(:page) { FakePage.new }
  let(:covdata) do
    Cucumber::Blanket.extract_from(page)
    Cucumber::Blanket.coverage_data
  end

  describe "#accrue!" do
    let(:new_page_data) do
      page_data = Marshal.load(Marshal.dump(covdata.data))
      page_data[0]['files'].first[1][0] = 3 # add coverage on that line
      page_data
    end
    it "squishes coverage datasets together" do
      covdata["files"].first[1][0].should be_nil
      covdata["files"].first[1][1].should eq 1
      covdata.accrue! new_page_data
      covdata["files"].first[1][0].should eq 3
      covdata["files"].first[1][1].should eq 2
    end
  end
end
