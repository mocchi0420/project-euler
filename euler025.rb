# coding: utf-8
# Problem 25 「1000桁のフィボナッチ数」

# 簡単な方針
# Matrix[[1,1],[1,0]]のべき乗を用いればフィボナッチ数列の数値をlog(n)の計算量で求められることを利用する。
# これを利用して調べたところ、1000桁の数値は2^12~2^13の間の数値であることが分かったので、1000桁を越えないようにする最大のMatrix[[1,1],[1,0]]の2^n乗を求め続け、
# それらの2^nを足し合わせたものを出力することを考えた。
require 'matrix'
def euler025(index = 1000)

	digit = 0
	ret = 0
	flag = true
	
	while flag == true	
		if ((Matrix[[1,1],[1,0]]**((2**digit + ret)))[0,1]).to_s.length >= 1000
			if digit > 0
				ret += (2**(digit-1))
			else
				ret += 1
			end
			digit = 0
		else
			digit += 1
		end
		
		if ((Matrix[[1,1],[1,0]]**((ret)))[0,1]).to_s.length == 1000
			break
		end
	end
	return ret
end

=begin
def euler025(index=1000)
	memo = [0,1]
	count = 2
	fib_num = 0
	digit = fib_num.to_s.length # わざわざ10^999のような巨大な数値を持たずに文字列の長さ=桁として考える
	
	while digit < index do
		count += 1
		fib_num = get_fib(count, memo)
		digit = fib_num.to_s.length
	end
	return count
end

def get_fib(num, memo)
	memo.size.upto(num) do |idx|
		memo[idx] = memo[idx-1] + memo[idx-2] 
	end
	return memo[num]
end
=end