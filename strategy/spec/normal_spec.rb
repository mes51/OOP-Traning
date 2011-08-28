# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe Normal do
  before do
    @conv = Normal.new
  end

  describe "#convert" do
    it "should equals string" do
      @conv.convert(1234567890).should == "1234567890"
    end
  end
end
