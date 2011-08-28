# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe Oct do
  before do
    @conv = Oct.new
  end

  describe "#convert" do
    it "should equals string" do
      @conv.convert(1234567890).should == "11145401322"
    end
  end
end
