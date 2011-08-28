# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe English do
  before do
    @conv = English.new
  end

  describe "#convert" do
    it "raise ArgumentError at grater than 10^66" do
      lambda {
        @conv.convert(10 ** 66);
      }.should raise_error(ArgumentError)
    end

    it "should equals string" do
      @conv.convert(1234567890).should == "one billion two hundred thirty four million five hundred sixty seven thousand eight hundred ninety"

      @conv.convert(1024).should == "one thousand twenty four"

      @conv.convert(1001000).should == "one million one thousand"

      @conv.convert(10 ** 65).should == "one hundred vigintillion"
    end
  end
end
