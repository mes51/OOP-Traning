# -*- coding: utf-8 -*-

class Japanese
  NUMBER = [
    "", "一", "二", "三",
    "四", "五", "六", "七",
    "八", "九"
  ]

  UNIT = [
    "", "十", "百", "千"
  ]

  CLASS = [
    "",         #10^0
    "万",       #10^4
    "億",       #10^8
    "兆",       #10^12
    "京",       #10^16
    "垓",       #10^20
    "秭",       #10^24
    "穣",       #10^28
    "溝",       #10^32
    "澗",       #10^36
    "正",       #10^40
    "載",       #10^44
    "極",       #10^48
    "恒河沙",   #10^52
    "阿僧祇",   #10^56
    "那由他",   #10^60
    "不可思議", #10^64
    "無量大数"  #10^68
  ]

  def convert num
    if Math.log10(num) > 71
      raise ArgumentError
    end

    result = ""

    CLASS.each do |c|
      ct = num % 10000
      s = ""

      UNIT.each do |u|
        ut = ct % 10
        if (u.length > 0 && ut > 1) || (u.length == 0 && ut > 0)
          s = NUMBER[ut] + u + s
        elsif (ut > 0)
          s = u + s
        end

        ct /= 10
        if ct <= 0
          break
        end
      end

      if s.length > 0
        result = s + c + " " + result
      end

      num /= 10000
      if num <= 0
        break
      end
    end

    result.strip
  end
end
