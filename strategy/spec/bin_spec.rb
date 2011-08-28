# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe Bin do
  before do
    @conv = Bin.new
  end

  describe "#convert" do
    it "should equals string" do
      @conv.convert(1234567890).should == "1001001100101100000001011010010"
    end
  end
end
