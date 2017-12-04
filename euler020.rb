# coding: utf-8
# Problem 20 「各位の数字の和 2」

# 簡単な方針
# Rubyぱわーでてきとうにけいさん

def euler020(index=100)	
	return fact(index).to_s.split("").map{|d| d.to_i}.inject(:+)
end


def fact(n)
  (1..n).to_a.inject(1) {|f, i| f*i}
end