# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe NumberConverter do
  before do
    @conv = NumberConverter.new
  end

  describe "#convert" do
    context "use Normal" do
      it "should equals string" do
        @conv.convert("1234567890", Normal.new).should == "1234567890"
      end
    end
  
    context "use Comma" do
      it "should equals string" do
        @conv.convert("1234567890", Comma.new).should == "1,234,567,890"
      end
    end

    context "use Hex" do
      it "should equals string" do
        @conv.convert("1234567890", Hex.new).should == "499602D2"
      end
    end
    context "use Oct" do
      it "should equals string" do
        @conv.convert("1234567890", Oct.new).should == "11145401322"
      end
    end
    context "use Bin" do
      it "should equals string" do
        @conv.convert("1234567890", Bin.new).should == "1001001100101100000001011010010"
      end
    end
    context "use English" do
      it "should equals string" do
        @conv.convert("1234567890", English.new).should == "one billion two hundred thirty four million five hundred sixty seven thousand eight hundred ninety"
      end
    end
    context "use Japanese" do
      it "should equals string" do
        @conv.convert("1234567890", Japanese.new).should == "十二億 三千四百五十六万 七千八百九十"
      end
    end
 
  end
end
