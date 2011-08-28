# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe Comma do
  before do
    @conv = Comma.new
  end

  describe "#convert" do
    it "should equals string" do
      @conv.convert(1234567890).should == "1,234,567,890"
    end
  end
end
