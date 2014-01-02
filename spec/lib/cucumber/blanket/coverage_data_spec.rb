require 'spec_helper'

describe Cucumber::Blanket::CoverageData do
  before(:each) { Cucumber::Blanket.reset! }
  let(:page) { FakePage.new }
  let(:covdata) do
    Cucumber::Blanket.extract_from(page)
    Cucumber::Blanket.coverage_data
  end

  describe "#accrue!" do
    let(:new_page_data) do
      page_data = Marshal.load(Marshal.dump(covdata.data))
      page_data['files'].first[1][0] = 3 # add coverage on that line
      page_data
    end
    it "squishes coverage datasets together" do
      covdata["files"].first[1][0].should be_nil
      covdata["files"].first[1][1].should eq 1
      covdata.accrue! new_page_data
      covdata["files"].first[1][0].should eq 3
      covdata["files"].first[1][1].should eq 2
    end

    context "filename exists but is not iterable" do
      let(:new_page_data) do
        Marshal.load(Marshal.dump(covdata.data))
      end
      before do
        @data_copy = new_page_data
        @filename = covdata['files'].first[0]
        covdata['files'][@filename] = nil
      end
      it "will not try to iterate over nil" do
        expect {covdata.accrue! @data_copy}.not_to raise_error
      end
    end
  end


  describe "#files" do
    it "shorthand for accessing the files hash" do
      covdata.files.should eq covdata.data['files']
      covdata.files.should be_a Hash
    end
    it "has a shortcut that produces the same data" do
      Cucumber::Blanket.files.should eq covdata.files
    end
  end

  describe "#sources" do
    it "shorthand for accessing the sources hash" do
      covdata.sources.should eq covdata.data['sources']
      covdata.sources.should be_a Hash
    end
    it "has a shortcut that produces the same data" do
      Cucumber::Blanket.sources.should eq covdata.sources
    end
  end
end
