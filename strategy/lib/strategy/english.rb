# -*- coding: utf-8 -*-

class English
  NUMBER = [
    "", "one", "two",
    "three", "four", "five",
    "six", "seven", "eight",
    "nine", "ten", "eleven",
    "twelve", "thirteen", "fourteen",
    "fifteen", "sixteen", "seventeen",
    "eighteen", "nineteen"
  ]
  TEN_DIGIT = [
    "twenty", "thirty", "forty",
    "fifty", "sixty", "seventy",
    "eighty", "ninety", 
  ]
  HUNDRED = "hundred"
  CLASS = [
    "",                  #10^0
    "thousand",          #10^3
    "million",           #10^6
    "billion",           #10^9
    "trillion" ,         #10^12
    "quadrillion",       #10^15
    "quintillion" ,      #10^18
    "sixtillion",        #10^21
    "septillion",        #10^24
    "octillion",         #10^27
    "nonillion",         #10^30
    "decillion",         #10^33
    "unodecillion",      #10^36
    "duodecillion",      #10^39
    "tredecillion",      #10^42
    "quattuordecillion", #10^45
    "quindecillion" ,    #10^48
    "sexdecillion",      #10^51
    "septendecillion",   #10^54
    "octodecillio",      #10^57
    "novemdecillion",    #10^60
    "vigintillion",      #10^63
  ]

  def convert num
    if Math.log10(num) > 65
      raise ArgumentError
    end

    result = ""

    CLASS.each do |c|
      t = num % 1000
      s = ""
      
      if t >= 100
        s += NUMBER[t / 100] + " " + HUNDRED + " "
        t %= 100
      end

      if t >= 20
        s += TEN_DIGIT[t / 10 - 2] + " "
        t %= 10
      end
      if t > 0
        s += NUMBER[t] + " "
      end
      
      if s.length > 0
        result = s + c + " " + result
      end

      num /= 1000
      if num <= 0
        break
      end
    end

    result.strip
  end
end
