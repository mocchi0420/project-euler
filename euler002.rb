# coding: utf-8
# Problem 2 「偶数のフィボナッチ数」
def euler002(threshold = 4000000)
	ret = 0
	1.step do |tmp|
		fib_num = calc_fib(tmp)
		ret += fib_num if fib_num.even?
		break if fib_num > threshold
	end
	return ret
end

def calc_fib(n, a=0, b=1)
	return n.even? ? -calc_fib(-n) : calc_fib(-n) if n < 0
	return a if n < 1
	calc_fib(n-1, b, a+b)
end