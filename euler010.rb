# coding: utf-8
# Problem 10 「素数の和」


require 'prime'
def euler010
	return Prime.each(2000000).to_a.inject(:+)
end

# ちゃんと手も動かした証拠を残しておく
=begin
def euler010(threshold=2000000)
	count=0
	base = 0
	ret = 0
	
	while base < threshold do
		if base < 3
			base += 1
		else
			base += 2
		end
		ret += base if isprime(base)
	end

	return ret
end

def isprime(n)
	return true if n == 2
	return false if n % 2 == 0 || n < 2
	
	i=3
	while i <= Math.sqrt(n)
		return false if n % i == 0
		i += 1
	end
	return true
end
=end
