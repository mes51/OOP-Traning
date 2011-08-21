# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe VendingMachine do
  before do
    @vending = VendingMachine.new
  end

  describe "#input_money" do
    it "should be true at after input 10 yen" do
      @vending.input_money(:ten).should be_true
    end

    it "should be true at after input 50 yen" do
      @vending.input_money(:fifty).should be_true
    end

    it "should be true at after input 100 yen" do
      @vending.input_money(:one_hundred).should be_true
    end

    it "should be true at after input 500 yen" do
      @vending.input_money(:five_hundred).should be_true
    end

    it "should be true at after input 1000 yen" do
      @vending.input_money(:one_thousand).should be_true
    end

    it "should raise ArgumentError other money" do
      lambda {
        @vending.input_money :one
      }.should raise_error(ArgumentError)
    end
  end

  describe "#total_money" do
    it "should equals 0 before input money" do
      @vending.total_money.should == 0
    end

    it "should equals total input money" do
      @vending.input_money :ten
      @vending.total_money.should == 10

      @vending.input_money :fifty
      @vending.total_money.should == 60

      @vending.input_money :one_hundred
      @vending.total_money.should == 160

      @vending.input_money :five_hundred
      @vending.total_money.should == 660

      @vending.input_money :one_thousand
      @vending.total_money.should == 1660
    end
  end

  describe "#get_can_buy_list" do
    it "should not have :cola when total input money less than 120 yen" do
      @vending.input_money :ten

      @vending.get_can_buy_list.count.should == 0
    end

    it "should have id :cola when total input money grater equals than 120 yen" do
      @vending.input_money :one_hundred
      @vending.input_money :ten
      @vending.input_money :ten

      @vending.get_can_buy_list.index(:cola).should_not be_nil
    end

    it "should have id :redbull when total input money grater equals than 200 yen" do
      @vending.input_money :one_hundred
      @vending.input_money :one_hundred

      @vending.get_can_buy_list.index(:redbull).should_not be_nil
    end

    it "should have id :water when total input money grater equals than 100 yen" do
      @vending.input_money :one_hundred

      @vending.get_can_buy_list.index(:water).should_not be_nil
    end

   it "should not have :cola when stock is 0" do
      @vending.input_money :one_thousand
      5.times { |i|
        @vending.buy :cola
      }

      @vending.get_can_buy_list.index(:cola).should be_nil
    end

   it "should not have :redbull when stock is 0" do
      @vending.input_money :one_thousand
      @vending.input_money :one_thousand
      5.times { |i|
        @vending.buy :redbull
      }

      @vending.get_can_buy_list.index(:redbull).should be_nil
   end

   it "should not have :water when stock is 0" do
      @vending.input_money :one_thousand
      5.times { |i|
        @vending.buy :water
      }

      @vending.get_can_buy_list.index(:water).should be_nil
    end

    it "should equals 0 when can not return any type money" do
      3.times { |i|
        @vending.input_money :one_thousand
        @vending.buy :cola
        @vending.return_shortchange
      }
      @vending.input_money :one_thousand

      @vending.get_can_buy_list.count.should == 0
    end
  end

  describe "#buy" do
    it "should raise ArgumentError at not stock drink" do
      @vending.input_money :five_hundred

      lambda {
        @vending.buy :tea
      }.should raise_error(ArgumentError)
    end

    it "should raise ArgumentError at less than have to buy drink" do
      @vending.input_money :ten

      lambda {
        @vending.buy :cola
      }.should raise_error(ArgumentError)

       lambda {
        @vending.buy :redbull
      }.should raise_error(ArgumentError)

       lambda {
        @vending.buy :water
      }.should raise_error(ArgumentError)
    end

    it "should raise ArgumentError at drink stock is 0" do
      @vending.input_money :one_thousand
      @vending.input_money :one_thousand
      @vending.input_money :one_thousand

      5.times { |i|
        @vending.buy :cola
      }

      5.times { |i|
        @vending.buy :redbull
      }

      5.times { |i|
        @vending.buy :water
      }

      lambda {
        @vending.buy :cola
      }.should raise_error(ArgumentError)

      lambda {
        @vending.buy :redbull
      }.should raise_error(ArgumentError)

      lambda {
        @vending.buy :water
      }.should raise_error(ArgumentError)
    end

    it "should be true at total input money grater equals than cost" do
      @vending.input_money :one_hundred
      @vending.input_money :ten
      @vending.input_money :ten

      @vending.buy(:cola).should be_true

      @vending.input_money :one_hundred
      @vending.input_money :one_hundred

      @vending.buy(:redbull).should be_true

      @vending.input_money :one_hundred

      @vending.buy(:water).should be_true
    end

    it "subtract buy drink cost at total input money" do
      @vending.input_money :one_thousand
      @vending.buy :cola

      @vending.total_money.should == 880

      @vending.buy :redbull

      @vending.total_money.should == 680

      @vending.buy :water

      @vending.total_money.should == 580
    end

    it "should raise ArgumentError when can not return any type money" do
      3.times { |i|
        @vending.input_money :one_thousand
        @vending.buy :cola
        @vending.return_shortchange
      }
      @vending.input_money :one_thousand

      lambda {
        @vending.buy :cola
      }.should raise_error(ArgumentError)

      lambda {
        @vending.buy :redbull
      }.should raise_error(ArgumentError)

      lambda {
        @vending.buy :water
      }.should raise_error(ArgumentError)
    end
  end

  describe "#total_sales" do
    it "should equals total cost" do
      @vending.input_money :one_thousand
      @vending.buy :cola

      @vending.total_sales.should == 120

      @vending.buy :redbull

      @vending.total_sales.should == 320

      @vending.buy :water

      @vending.total_sales.should == 420
    end
  end

  describe "#drink_stock" do
    it "should equals 5 cola stocks" do
      @vending.drink_stock[:cola].should == 5
    end

    it "should equals 5 redbull stocks" do
      @vending.drink_stock[:redbull].should == 5
    end

    it "should equals 5 water stocks" do
      @vending.drink_stock[:water].should == 5
    end
  end

  describe "#return_shortchange" do
    it "should equals input money" do
      @vending.input_money :ten
      @vending.input_money :fifty
      @vending.input_money :one_hundred
      @vending.input_money :five_hundred
      @vending.input_money :one_thousand

      total = @vending.total_money
      return_money = @vending.return_shortchange

      return_money.each do |t, n|
        n.times { |i|
          @vending.input_money t
        }
      end

      @vending.total_money.should == total
    end

    it "should equals 0 after return shortchange" do
      @vending.input_money :one_thousand
      @vending.return_shortchange

      @vending.total_money.should == 0
    end
  end
end
