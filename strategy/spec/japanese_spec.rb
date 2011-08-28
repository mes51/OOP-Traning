# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe Japanese do
  before do
    @conv = Japanese.new
  end

  describe "#convert" do
    it "raise ArgumentError at grater than 10^72" do
      lambda {
        @conv.convert(10 ** 72);
      }.should raise_error(ArgumentError)
    end

    it "should equals string" do
      @conv.convert(1234567890).should == "十二億 三千四百五十六万 七千八百九十"

      @conv.convert(1111).should == "千百十一"

      @conv.convert(1024).should == "千二十四"

      @conv.convert(10 ** 71).should == "千無量大数"
    end
  end
end
