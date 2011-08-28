# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe Hex do
  before do
    @conv = Hex.new
  end

  describe "#convert" do
    it "should equals string" do
      @conv.convert(1234567890).should == "499602D2"
    end
  end
end
