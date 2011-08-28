# -*- coding: utf-8 -*-

class Comma
  def convert num
    result = (num % 1000).to_s
    num /= 1000
    while (num > 0)
      result = (num % 1000).to_s + "," + result
      num /= 1000
    end
    result
  end
end
