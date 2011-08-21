# -*- coding: utf-8 -*-

class VendingMachine
  def initialize
    @total_money = 0
    @total_sales = 0

    @money_type = {
      :ten => 10,
      :fifty => 50,
      :one_hundred => 100,
      :five_hundred => 500,
      :one_thousand => 1000
    }

    @money_stock = {
      :ten => 10,
      :fifty => 10,
      :one_hundred => 10,
      :five_hundred => 10,
      :one_thousand => 5
    }

    @drink_type = [
       Drink.new(:cola, 120),
       Drink.new(:redbull, 200),
       Drink.new(:water, 100)
    ]

    @drink_stock = {}
    @drink_type.each do |d|
      @drink_stock[d.id] = 5
    end
  end

  attr_reader :total_money
  attr_reader :total_sales
  attr_reader :drink_stock

  def input_money money
    if @money_type[money]
      @total_money += @money_type[money]
      @money_stock[money] += 1
      true
    else
      raise ArgumentError
    end
  end

  def get_can_buy_list
    result = []
    @drink_type.each do |d|
      if (d.cost <= @total_money && @drink_stock[d.id] > 0 &&
          can_return_shortchange(@total_money - d.cost))
        result << d.id
      end
    end

    result
  end

  def buy id
    @drink_type.each do |d|
      if d.id == id
        if (d.cost <= @total_money && @drink_stock[id] > 0 &&
            can_return_shortchange(@total_money - d.cost))
          @drink_stock[id] -= 1
          @total_sales += d.cost
          @total_money -= d.cost
          return true
        end
        break
      end
    end
    raise ArgumentError
  end

  def return_shortchange
    result = {}

    @money_type.sort { |a, b|
      b[1] <=> a[1]
    }.each do |t, v|
      result[t] = @total_money / v
      @total_money %= v
      @money_stock[t] -= result[t]
    end
    @total_money = 0

    result
  end

  def can_return_shortchange money
    @money_type.sort { |a, b|
      b[1] <=> a[1]
    }.each do |t, v|
      if @money_stock[t] < money / v
        return false
      end
      money %= v
    end
    true
  end
  private :can_return_shortchange
end
