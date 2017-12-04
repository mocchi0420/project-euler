# coding: utf-8
# Problem 16 「各位の数字の和」

# 簡単な方針
# Rubyぱわーでてきとうにけいさん

def euler016(index=1000)	
	return (2**index).to_s.split("").map{|d| d.to_i}.inject(:+)
end