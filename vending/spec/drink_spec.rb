# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe Drink do
  before do
    @id = :cola
    @cost = 120

    @drink = Drink.new @id, @cost
  end

  describe "#id" do
    it "should equals @id" do
      @drink.id.should == @id
    end
  end

  describe "#cost" do
    it "should equals @cost" do
      @drink.cost.should == @cost
    end
  end
end
